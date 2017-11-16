function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4
  });
  var bounds = new google.maps.LatLngBounds();

/*
  var n = markers.length;
  for (var i = 0; i < n; i++) {
    var marker = new google.maps.Marker({
      position: {lat: parseFloat(markers[i].latitude), lng: parseFloat(markers[i].longitude)},
      title: markers[i].name,
      map: map
    });
    bounds.extend(marker.position);
  }
*/

  map.fitBounds(bounds);
}
