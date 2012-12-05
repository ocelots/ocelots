$ ->
  geocoder = null
  map = null
  marker = null

  $("#map_canvas").each ->
      geocoder = new google.maps.Geocoder()
      lat = parseFloat($('#person_lat').val()) || -34.397
      lng = parseFloat($('#person_lng').val()) || 150.644
      latlng = new google.maps.LatLng(lat, lng)
      mapOptions = {
        zoom: 8
        center: latlng
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
      marker_options = {
        draggable: true,
        position: new google.maps.LatLng(lat, lng),
        map: map
      }
      marker = new google.maps.Marker(marker_options)
      google.maps.event.addListener marker, 'dragend', (event) ->
            point = marker.getPosition()
            $('#person_lat').val point.lat()
            $('#person_lng').val point.lng()

  $("#address_btn").live "click", (e) ->
      address = $("#address").val()
      geocoder.geocode { 'address': address}, (results, status) ->
        if (status == google.maps.GeocoderStatus.OK)
          map.setCenter(results[0].geometry.location)
          marker.setMap null
          marker = new google.maps.Marker {
              map: map,
              position: results[0].geometry.location
          }
          $('#person_lat').val(results[0].geometry.location.$a)
          $('#person_lng').val(results[0].geometry.location.ab)
        else
          alert "Geocode was not successful for the following reason: " + status
      false