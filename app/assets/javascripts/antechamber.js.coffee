$ ->
  options=
    type:'post'
    clearForm: true
    beforeSubmit: ->
      if $('.message-body').val().replace(/\s+/, "") == ""
        false
    success: (data) ->
      $('.message-list').prepend(data)

  $('.submit-mess').click ->
    $('.form-inline').ajaxSubmit options
