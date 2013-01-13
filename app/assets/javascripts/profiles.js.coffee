$ ->
  $('#view_map').each ->
    lat = $(this).data('lat')
    lng = $(this).data('lng')

    map_options = {
      center: new google.maps.LatLng(lat, lng),
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(this, map_options)

    marker_options = {
      position: new google.maps.LatLng(lat, lng),
      map: map
    }
    marker = new google.maps.Marker(marker_options)