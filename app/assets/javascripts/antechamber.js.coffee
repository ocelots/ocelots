$ ->
  options=
    type:'post'
    clearForm: true
    beforeSubmit: ->
      if $('.message-body').val()==""  or  $('.message-body').val()==" "
        false
    success: (data) ->
      $('.message-list').prepend(data)

  $('.submit-mess').click ->
    $('.form-inline').ajaxSubmit options
