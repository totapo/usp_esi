//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
//dps que o js estiver funcionando refatoramos pra fazer em coffeescript

var route; //guarda os marcadores da rota atual no mapa

var spots; //guarda os pontos cadastrados na base

var canAdd; //indica se o uusario pode marcar outro lugar no mapa
var map; //mapa
var geocoder; //codifica os enderecos
var infowindow; //pra mostrar os endereços nos marcadores
var counter; //conta as posicoes preenchidas em rote (n elementos)
var edit;


$('#lista_sem_padding').on("click", "a#remPoint",function(e) {e.preventDefault(); removePoint(e.target); return false;});
$('#lista_sem_padding').on("click", "a#centerPoint",function(e) {e.preventDefault(); centerIn(e.target); return false;});

$('#addSpots').on('click', function(e){
  e.preventDefault();
  var paradas = getParadasSelecionadas();

  if(paradas.length>0){
      $.ajax({
            url:'/spots',
            type:'POST',
            dataType:'json',
            data:{
                stops:paradas,
                authenticity_token: window._token
            },
            success:function(data){
              window.location.reload(true);
            },
            error:function(data){
              window.alert("Erro no servidor!")
            }
        });
  } else {
    window.alert("Nenhum ponto de parada adicionado!")
  }

  return false;
});

function getParadasSelecionadas(){
  var count;
  var resp=new Array();
  var aux;
  for(count=0; count<route.length; count++){
    aux=new Object();
    aux.id = route[count].get('spot_id');
    aux.address = route[count].get('spot_address');
    aux.lat = route[count].getPosition().lat();
    aux.lng = route[count].getPosition().lng();
    resp.push(aux);
  }
  return resp;
}

/*function test(dom){
  var pos=parseInt(dom.getAttribute("listposition"));
  alert(pos);
}*/

function initVariables(){
  route = new Array();
  addresses = new Array();
  canAdd=true;
  edit=false;
  geocoder = new google.maps.Geocoder;
  infowindow = new google.maps.InfoWindow;
  counter=0;
  spots=new Array();
}
var i=0;
function loadSpots(){
  $("#spots").children().each(function(){
    var lat = parseFloat(this.getAttribute("lat"));
    var lng = parseFloat(this.getAttribute("lng"));
    var id = parseInt(this.getAttribute("id"))
    var address = this.getAttribute("add");
    var latlng = {lat:lat,lng:lng}
    setTimeout(function(){
      createMarker(latlng,id,address,function(marcador){
        spots[marcador.get('spot_id')]=marcador;
      })
    }, 100*i);
    i++;
  });
}

function createMarker(latlng, id, add,callBackFunction){
  if(add){
    var marcador = new google.maps.Marker({
      position: latlng,
      map: map,

      //custom parameters
      spot_address: add,
      spot_id: id
    });

    //adiciona na rota (adicona repetidamente tb)
    marcador.addListener('dblclick',function(evt){
      addToPanel(marcador);
    });

    //mostra infowindow
    marcador.addListener('click',function(evt){
      infowindow.setContent(marcador.get('spot_address'));
      infowindow.open(map,marcador);
    });
    if(callBackFunction){
      callBackFunction(marcador);
    }
  } else {
    geocoder.geocode({'location': latlng}, function(results, status) {
      if (status === 'OK') {
        if (results[0]) {
          createMarker(latlng,id,results[0].formatted_address,callBackFunction)

        } else {
          window.alert('No results found');
          return null;
        }
      } else {
        window.alert('Geocoder failed due to: ' + status);
        return null;
      }
    });
  }
}

function initMap() {
  initVariables();
  directionsService = new google.maps.DirectionsService();
  directionsDisplay = new google.maps.DirectionsRenderer();

  var myLatlng = {lat: -23.533773, lng: -46.625290};

  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: myLatlng
  });

  map.setOptions({disableDoubleClickZoom: true });

  map.addListener('dblclick', function(event) {
    //window.alert("triggered");
    if(canAdd){
      canAdd=false;
      var latlng = event.latLng;
      var marker = createMarker(latlng,-1,null,addToPanel);
    }
  });

  directionsDisplay.setMap(map);

  loadSpots();
}

function addToPanel(marker){
  if(marker){
    infowindow.setContent(marker.get('spot_address'));
    infowindow.open(map, marker);
    route.push(marker);
    addPoint();
  }
}

function addPoint() {
    appendPointTo(route[counter].get('spot_address'),counter);
    counter++;
    canAdd=true;
}

function appendPointTo(address,pos){
  $('#lista_sem_padding').append(

    '<li class="list-group-item list_item" id="list_'+pos+'">'+
      '<a href="" id="centerPoint" listposition="'+pos+'">'+
        address.substr(0,20)+'...'+
      '</a>'+
      '<div class="pull-right action-buttons" id="botoes_lista">'+
        '<a href="" id="remPoint" listposition="'+pos+'" role="button" class="btn btn-danger btn-sm"><i class="fa fa-window-close-o fa-fw" listposition="'+pos+'"></i></a>'+
      '</div>'+
    '</li>'
  );
}

function refreshList(){
  $('#lista_sem_padding').empty();
  var cnt;
  for(cnt=0; cnt<route.length; cnt++){
    appendPointTo(route[cnt].get('spot_address'),cnt);
  }
}

function centerIn(dom){
  var pos = parseInt(dom.getAttribute("listposition"));
  var m = route[pos];
  infowindow.setContent(m.get('spot_address'));
  infowindow.open(map,m);
}

function removePoint(dom) {
    var pos = parseInt(dom.getAttribute("listposition"));
    if(pos<counter && pos>=0){
      var a = pos;

      //destroi o marcador no mapa se ele foi adicionado (nao possui spot_id)
      var mark = route[pos];
      if(parseInt(mark.get('spot_id'))>=0){
        $.ajax({
          type: "POST",
          url: "/spots/" + mark.get('spot_id'),
          dataType: "json",
          data: {"_method":"delete",
                  authenticity_token: window._token},
          success:function(data){
            //do nothing TODO
          },
          error:function(data){
            window.alert("Erro no servidor!");
            window.location.reload(true);
          }
        });
      }

      mark.setMap(null);
      mark=null;
      //sobe os elementos antigos um nivel
      for(a=pos; a<route.length-1; a++){
        route[a]=route[a+1];
      }

      //apaga os elementos duplicados no fim das listas
      route.pop();
      counter--;

      refreshList();
    }
}
