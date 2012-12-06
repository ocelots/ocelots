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


