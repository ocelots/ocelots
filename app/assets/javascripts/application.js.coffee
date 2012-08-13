//= require jquery
//= require jquery_ujs
//= require bootstrap

$ ->
  $('#authenticate').click ->
    navigator.id.get (assertion) ->
      if assertion
        $.post '/home/verify', { assertion: assertion }, (data) ->
          window.location = '/'