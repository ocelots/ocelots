$ ->
  options=
    type:'post'
    clearForm: true
    beforeSubmit: ->
      if $('.message-body').val().replace(/\s+/, "") == ""
        false

  $('.submit-mess').click ->
    $('.form-inline').ajaxSubmit options

  pusher = new Pusher $('#pusher_key').val()
  channel = pusher.subscribe $('#team_name').val()
  channel.bind 'new_message', (data) ->
    $('.message-list').prepend(data.content).show('slow')
