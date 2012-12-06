$ ->
  toggle_hidden = (show, selector) ->
    if show
      $(selector).removeClass("hidden")
    else
      $(selector).addClass("hidden")
    toggle_hidden_by_search($('#show-filter').val())

  $('#show-past').change -> toggle_hidden(this.checked, '.past')
  $('#show-current').change -> toggle_hidden(this.checked, '.current')
  $('#show-future').change -> toggle_hidden(this.checked, '.future')
  $('#show-pending').change -> toggle_hidden(this.checked, '.pending')

  $('#show-filter').keyup (event) ->
    switch event.which
      when 27 then $('#show-filter').val('')
    toggle_hidden_by_search($('#show-filter').val())

  toggle_hidden_by_search = (str) ->
    reg = new RegExp(str, 'i')
    $('.team-fliter input:checked').next().each (i, e) ->
      $('.' + $(e).text() + ' .full-name').each (j, v)->
        if $(v).text().search(reg) + 1
          $(v).parent().parent().parent().removeClass("hidden")
        else
          $(v).parent().parent().parent().addClass("hidden")

  $('#show-filter').keydown (event) ->

    event.preventDefault() if event.which == 13

  $('#add_new').click ->
    $('.team-content').hide 'slow'
    $('#new-content').show 'slow'

  $('.cancel-add').click ->
    $('.team-content').show 'slow'
    $('#new-content').hide 'slow'

  options=
    type:'post'
    clearForm: true
    beforeSubmit: ->
      if $('.members-content').val().replace(/\s+/, "") == ""
        false
    success: (data) ->
      node = $('<div></div>').addClass('alert').text data.message
      if data.status == 'success'
        node.addClass('alert-success')
      else
        node.addClass('alert-error')
      node.insertBefore('p.alert.alert-info')
      setTimeout  ()->
        node.hide('slow').remove()
      ,4000
    error: ->
      node = $('<div></div>').addClass('alert').addClass('alert-error').text 'Sorry,there are some errors occured.'
      node.insertBefore('p.alert.alert-info')
      setTimeout  ()->
        node.hide('slow').remove()
      ,4000
  $('.do-add').click ->
    $('.add-member-form').ajaxSubmit options