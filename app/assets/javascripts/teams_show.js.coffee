$ ->
  toggle_hidden = (show, selector) ->
    if show
      $(selector).removeClass("hidden")
    else
      $(selector).addClass("hidden")

  $('#show-past').change -> toggle_hidden(this.checked, '.past')
  $('#show-current').change -> toggle_hidden(this.checked, '.current')
  $('#show-future').change -> toggle_hidden(this.checked, '.future')
  $('#show-pending').change -> toggle_hidden(this.checked, '.pending')

  $('#show-filter').keyup (event) ->
    switch event.which
      when 27 then $('#show-filter').val('')

  $('#show-filter').keydown (event) -> event.preventDefault() if event.which == 13