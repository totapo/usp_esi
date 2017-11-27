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
var maxSpots; //quantidade de spots que o mapa deve mostrar
var actualSpots; //quantidade de spots carregados atualmente
var currentLineId;
var rChanged; //indica se houve mudanca na ordem dos pontos/adicao de pontos na rota


$('#lista_sem_padding').on("click", "a#upPoint",function(e) {e.preventDefault(); rChanged=true; moveUp(e.target);return false;})
$('#lista_sem_padding').on("click", "a#downPoint",function(e) {e.preventDefault(); rChanged=true; moveDown(e.target); return false;});
$('#lista_sem_padding').on("click", "a#remPoint",function(e) {e.preventDefault(); rChanged=true; removePoint(e.target); return false;});
$('#lista_sem_padding').on("click", "a#centerPoint",function(e) {e.preventDefault(); centerIn(e.target); return false;});

$('#addRoute').on('click', function(e){
  e.preventDefault();
  var n=$('#route_name').val();
  var paradas = getParadasSelecionadas();

  if(n && n.trim().length>0 && paradas.length>1){
    post = {};
    complement='';
    if(edit==true){
      complement='/'+currentLineId; //TODO id
      post={
          line:{
            name: n,
            id: currentLineId
          },
          stops:paradas,
          authenticity_token: window._token,
          _method:'put'
      }
    } else {
      post={
          line:{
            name: n
          },
          stops:paradas,
          authenticity_token: window._token
      }
    }
    $.ajax({
          url:'/lines'+complement,
          type:'POST',
          dataType:'json',
          data:post,
          success:function(data){
            window.location.reload(true);
          },
          error:function(data){
            window.alert("Erro no servidor!");
          }
      });
  } else {
    window.alert("Rota inválida!");
  }

  return false;
});

$('#remRoute').on('click', function(e){
  e.preventDefault();
  var n=$('#route_name').val();

  if(n && currentLineId){
    post = {};
    complement='';

    $.ajax({
        type: "POST",
        url: "/lines/" + currentLineId,
        dataType: "json",
        data: { _method:"delete",
                routeChanged:rChanged,
                authenticity_token: window._token},
        success:function(data){
          window.location.reload(true);
        },
        error:function(data){
          window.alert("Erro no servidor!");
        }
      });
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
  loaded=false;
  setScreen(true);
  rChanged=false;
}
var i=0;
function loadSpots(){
  maxSpots = $("#spots").children().length;
  actualSpots=0;
  $("#spots").children().each(function(){
    var lat = parseFloat(this.getAttribute("lat"));
    var lng = parseFloat(this.getAttribute("lng"));
    var id = parseInt(this.getAttribute("id"))
    var address = this.getAttribute("add");
    var latlng = {lat:lat,lng:lng}
    setTimeout(function(){
      createMarker(latlng,id,address,function(marcador){
        spots[marcador.get('spot_id')]=marcador;
        actualSpots++;
        if(actualSpots==maxSpots){
          setScreen(false);
        }
      });
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
      rChanged=true;
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
  if(pos<route.length-1){
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
    if(pos<route.length && pos>=0){
      var a = pos;

      //destroi o marcador no mapa se ele foi adicionado (nao possui spot_id)
      var mark = route[pos];

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
    currentLineId= parseInt(op.getAttribute('lineid'));
    rChanged=false;
    if(currentLineId<0){
      edit=false;
      $('#route_name').val("");
      $('#addRoute').text("Adicionar");
      route=[];
      resetDisplayedRoutes();
      refreshList();
    } else {
      edit=true;
      setScreen(true); //disables buttons and select
      $('#route_name').val(op.innerHTML+"");

      $('#addRoute').text("Editar");
      $.ajax({
            url:'/lines/'+currentLineId,
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
    $('#addRoute').removeAttr('href');
    $('#remRoute').removeAttr('href');
  } else {
    $('#addRoute').attr('href',"");
    $('#remRoute').attr('href',"");
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
