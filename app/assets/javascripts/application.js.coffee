//= require jquery
//= require jquery_ujs

$ ->
  $('#authenticate').click ->
    navigator.id.get (assertion) ->
      if assertion
        $.post '/home/verify', { assertion: assertion }, (data) ->
          window.location = '/'

  $('.quiz').click ->
    if $(this).data('correct')
      $(this).find('.highlight').removeClass('highlight').addClass('correct')
    else
      $(this).find('.highlight').removeClass('highlight').addClass('incorrect')
    false


  $('.fancybox').fancybox()

#  $("#map_canvas").each ->
#    lat = parseFloat($('#person_lat').val()) || -34.397
#    lng = parseFloat($('#person_lng').val()) || 150.644
#
#    map_options = {
#      center: new google.maps.LatLng(lat, lng),
#      zoom: 8,
#      mapTypeId: google.maps.MapTypeId.ROADMAP
#    }
#
#    map = new google.maps.Map(this, map_options)
#
#    marker_options = {
#      draggable: true,
#      position: new google.maps.LatLng(lat, lng),
#      map: map
#    }
#    marker = new google.maps.Marker(marker_options)
#
#    google.maps.event.addListener marker, 'dragend', (event) ->
#      point = marker.getPosition()
#      $('#person_lat').val point.lat()
#      $('#person_lng').val point.lng()


