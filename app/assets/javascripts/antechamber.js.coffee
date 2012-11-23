$ ->
  options=
    type:'post'
    clearForm: true
    success: (data) ->
      $('.message-list').prepend(data)

  $('.submit-mess').click ->
    $('.form-inline').ajaxSubmit options
