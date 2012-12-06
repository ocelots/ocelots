$ ->
  $('#show-filter').keyup (event) ->
    switch event.which
      when 27 then $('#show-filter').val('')
    toggle_hidden_by_search($('#show-filter').val())

  toggle_hidden_by_search = (str) ->
    reg = new RegExp(str, 'i')
    $('.team_name').each (j, v)->
      if $(v).text().search(reg) + 1
        $(v).parent().parent().parent().parent().removeClass("hidden")
      else
        $(v).parent().parent().parent().parent().addClass("hidden")

  $('#show-filter').keydown (event) ->

    event.preventDefault() if event.which == 13