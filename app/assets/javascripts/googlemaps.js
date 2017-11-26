var map;
var infowindow;
var geocoder;

var rad = function(x) {
  return x * Math.PI / 180;
};

// returns distance between two points in meters.
var getDistance = function(p1, p2) {
  var R = 6378137; // Earth’s mean radius in meter
  var dLat = rad(p2.lat() - p1.lat());
  var dLong = rad(p2.lng() - p1.lng());
  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(rad(p1.lat())) * Math.cos(rad(p2.lat())) *
    Math.sin(dLong / 2) * Math.sin(dLong / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c;
  return d; // returns the distance in meter
};


function initJobIndexMapAutoComplete(markersArray) {
  var input = document.getElementById('search_location');
  console.log(input);

  var autocomplete = new google.maps.places.Autocomplete(input);
  // Bind the map's bounds (viewport) property to the autocomplete object,
  // so that the autocomplete requests use the current map bounds for the
  // bounds option in the request.
  autocomplete.bindTo('bounds', map);

  var search_marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29),
		icon: {
			path: google.maps.SymbolPath.CIRCLE,
			scale: 10
		}
  });

  autocomplete.addListener('place_changed', function() {
    search_marker.setVisible(false);
  	//var bounds = new google.maps.LatLngBounds();
    var place = autocomplete.getPlace();

    if (!place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      window.alert("No details available for input: '" + place.name + "'");
      return;
    }

		map.setCenter(place.geometry.location);
		map.setZoom(17);  // Why 17? Because it looks good.

    search_marker.setPosition(place.geometry.location);
    search_marker.setVisible(true);

    //getPosition()
    //getDistance(p1,p2);

    var bounds = new google.maps.LatLngBounds();
    bounds.extend(search_marker.getPosition());
    for(var i=0; i < markersArray.length; i++) {
      var marker = markersArray[i];
      var distance = getDistance(marker.getPosition(), search_marker.getPosition());
      
      if (distance <= 5000) {
        bounds.extend(marker.getPosition());
        map.fitBounds(bounds);
      }
    }


  });
}

function initJobIndexMap() {
  var pyrmont = {lat: -33.867, lng: 151.195};

  map = new google.maps.Map(document.getElementById('map'), {
    center: pyrmont,
    zoom: 15
  });

  infowindow = new google.maps.InfoWindow();
  geocoder = new google.maps.Geocoder();
  var bounds = new google.maps.LatLngBounds();
  var markersArray = [];

  for (var i=0; i < g__jobs.length; i++) {
      var job = g__jobs[i];
      var job_route = g__job_routes[i];

      console.log(job);

      geocoder.geocode({
          'address': job.location
          }, createGeocodeCallback(job, job_route, bounds, markersArray)
      );
  }

	initJobIndexMapAutoComplete(markersArray);
}

function createGeocodeCallback(job, job_route, bounds, markersArray) {
    return function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            // Add marker on location
            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });

            markersArray.push(marker);

            google.maps.event.addListener(marker, 'click', function() {
              var myContent = "<h2>Job Title: " + job.title + "</h2>\n" +
                  "<p><strong>Description: </strong>" + job.description + "</p>" +
                  "<p><strong>When: </strong>" + job.work_date + "</p>" +
                  "<p><strong>Where: </strong>"+ job.location + "</p>" +
                  "<p><strong>Wage (hourly): </strong>" + job.hourly_pay + "</p>" +
                  "<p><strong>Payment Method: </strong>" + job.payment_method + "</p>" +
                  "<a href=\"" + job_route + "\">Go to this job's page</a>";
              infowindow.setContent(myContent);
              infowindow.open(map, this);
            });

            bounds.extend(marker.getPosition());
            map.fitBounds(bounds);

        } else {
            console.error("Geocode was not successful for the following reason: " + status);
        }
    };
}

// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

function initJobFormMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.8688, lng: 151.2195},
    zoom: 13
  });
  var input = document.getElementById('location');
  console.log(input);

  var autocomplete = new google.maps.places.Autocomplete(input);

  // Bind the map's bounds (viewport) property to the autocomplete object,
  // so that the autocomplete requests use the current map bounds for the
  // bounds option in the request.
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var infowindowContent = document.getElementById('infowindow-content');
  infowindow.setContent(infowindowContent);
  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  autocomplete.addListener('place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      window.alert("No details available for input: '" + place.name + "'");
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindowContent.children['place-icon'].src = place.icon;
    infowindowContent.children['place-name'].textContent = place.name;
    infowindowContent.children['place-address'].textContent = address;
    infowindow.open(map, marker);
  });
}


function initJobNewMap() {
  initJobEditMap();
}



function initJobShowMap() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(43.6532, 79.3832);
    var mapOptions = {
        zoom: 13,
        center: latlng
    };
    map = new google.maps.Map(document.getElementById("map"), mapOptions);
    // Call the codeAddress function (once) when the map is idle (ready)
    google.maps.event.addListenerOnce(map, 'idle', codeAddress);
}
function codeAddress() {
    console.log(address);
    geocoder.geocode({
        'address': address
    }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            // Center map on location
            map.setCenter(results[0].geometry.location);
            // Add marker on location
            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });
        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}
