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

  map_canvas = document.getElementById("map_canvas")

  if map_canvas
    map_options = {
      center: new google.maps.LatLng(-34.397, 150.644),
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(map_canvas, map_options)

    marker_options = {
      draggable: true,
      position: new google.maps.LatLng(-34.397, 150.644),
      map: map
    }
    marker = new google.maps.Marker(marker_options)