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


$('#lista_sem_padding').on("click", "a#upPoint",function(e) {e.preventDefault(); moveUp(e.target);return false;})
$('#lista_sem_padding').on("click", "a#downPoint",function(e) {e.preventDefault(); moveDown(e.target); return false;});
$('#lista_sem_padding').on("click", "a#remPoint",function(e) {e.preventDefault(); removePoint(e.target); return false;});
$('#lista_sem_padding').on("click", "a#centerPoint",function(e) {e.preventDefault(); centerIn(e.target); return false;});

$('#addRout').on('click', function(e){
  e.preventDefault();
  var n=$('#route_name').val();
  var paradas = getParadasSelecionadas();

  if(n && n.trim().length>0 && paradas.length>1){
    if(edit==true){
      //TODO fazer o request de edição da rota
    } else {
        $.ajax({
              url:'/spots',
              type:'POST',
              dataType:'json',
              data:{
                  route:{
                    name: n
                  },
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
      }
  } else {
    window.alert("Rota inválida!")
  }

  return false;
});

$('#drawRoute').on('click', function(e){
  e.preventDefault();
  resetDisplayedRoutes();
  drawRoute();
  return false;
});

function getParadasSelecionadas(){
  var count;
  var resp=new Array();
  var aux;
  for(count=0; count<route.length; count++){
    aux=new Object();
    aux.id = route[count].get('spot_id');
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

function loadSpots(){
  $("#spots").children().each(function(){
    var lat = parseFloat(this.getAttribute("lat"));
    var lng = parseFloat(this.getAttribute("lng"));
    var id = parseInt(this.getAttribute("id"))
    var latlng = {lat:lat,lng:lng}

    createMarker(latlng,id,function(marcador){
      spots[marcador.get('spot_id')]=marcador;
    });
  });
}

function createMarker(latlng, id,callBackFunction){
  geocoder.geocode({'location': latlng}, function(results, status) {
    if (status === 'OK') {
      if (results[1]) {
        var marcador = new google.maps.Marker({
          position: latlng,
          map: map,

          //custom parameters
          spot_address: results[1].formatted_address,
          spot_id: id
        });

        //adiciona na rota (adicona repetidamente tb)
        marcador.addListener('dblclick',function(evt){
          addToRoute(marcador);
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
        window.alert('No results found');
        return null;
      }
    } else {
      window.alert('Geocoder failed due to: ' + status);
      return null;
    }
  });
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
      var marker = createMarker(latlng,-1,addToRoute);
    }
  });

  directionsDisplay.setMap(map);

  loadSpots();
}

function addToRoute(marker){
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
          '<a href="" id="upPoint" listposition="'+pos+'" role="button"><i class="fa fa-level-up fa-fw" listposition="'+pos+'"></i></a>'+
          '<a href="" id="downPoint" listposition="'+pos+'" role="button"><i class="fa fa-level-down fa-fw" listposition="'+pos+'"></i></a>'+
          '<a href="" id="remPoint" listposition="'+pos+'" role="button"><i class="fa fa-window-close-o fa-fw" listposition="'+pos+'"></i></a>'+
      '</div>'+
    '</li>'
  );
}

function moveUp(dom){
  var pos = parseInt(dom.getAttribute("listposition"));
  if(pos>0){
    var auxM = route[pos];

    route[pos]=route[pos-1];

    route[pos-1]=auxM;

    refreshList();
  }
}

function refreshList(){
  $('#lista_sem_padding').empty();
  var cnt;
  for(cnt=0; cnt<route.length; cnt++){
    appendPointTo(route[cnt].get('spot_address'),cnt);
  }
}

function moveDown(dom){
  var pos = parseInt(dom.getAttribute("listposition"));
  if(pos<counter-1){
    var auxM = route[pos];

    route[pos]=route[pos+1];

    route[pos+1]=auxM;

    refreshList();
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
      if(parseInt(mark.get('spot_id'))<0){
          mark.setMap(null);
          mark=null;
      }

      //sobe os elementos antigos um nivel
      for(a=pos; a<route.length-1; a++){
        route[a]=route[a+1];
      }

      //apaga os elementos duplicados no fim das listas
      route.pop();
      counter--;

      refreshList();
    }
    /*if(counter >0){

    }
    canAdd=true;*/
}

function changeRoute(sel){
    var op = sel.options[sel.selectedIndex];
    var id = parseInt(op.getAttribute('lineid'));
    if(id<0){
      edit=false;
      $('#route_name').val("");
      $('#addRout').text("Adicionar");
      route=[];
      refreshList();
    } else {
      edit=true;
      setScreen(true); //disables buttons and select
      $('#route_name').val(op.innerHTML+"");
      $('#addRout').text("Editar");
      $.ajax({
            url:'/spots/'+id,
            type:'GET',
            dataType:'json',
            success:function(data){
              var cnt;
              route=[];
              for(cnt=0; cnt<data.length; cnt++){
                route.push(spots[data[cnt]['spot_id']]);
              }
              refreshList();
              setScreen(false);
              resetDisplayedRoutes();
              drawRoute();
            },
            error:function(data){
              setScreen(false);
              window.alert("Erro no servidor!");
            }
        });
    }
}

function setScreen(bool){
  $('#select_route').attr('disabled',bool);
  if(bool){
    $('#addRout').removeAttr('href');
    $('#remRout').removeAttr('href');
  } else {
    $('#addRout').attr('href',"");
    $('#remRout').attr('href',"");
  }
}
//directions api
var directionsDisplay;
var directionsService;

function resetDisplayedRoutes(){
  directionsDisplay.setMap(null); // clear direction from the map
  directionsDisplay.setPanel(null); // clear directionpanel from the map
  directionsDisplay = new google.maps.DirectionsRenderer(); // this is to render again, otherwise your route wont show for the second time searching
  directionsDisplay.setMap(map); //this is to set up again
}

function drawRoute() {
  if(route.length>1){
    var waypts = [];
    for (var i = 1; i < route.length-1; i++) {
      waypts.push({
        location: route[i].getPosition(),
        stopover: true
      });
    }
    directionsDisplay.setOptions({suppressMarkers: true})

    directionsService.route({
      origin: route[0].getPosition(),
      destination: route[route.length-1].getPosition(),
      waypoints: waypts,
      optimizeWaypoints: true,
      travelMode: 'DRIVING'
    }, function(response, status) {
      if (status === 'OK') {
        directionsDisplay.setDirections(response);
      } else {
        window.alert('Directions request failed due to ' + status);
      }
    });
  }
}
