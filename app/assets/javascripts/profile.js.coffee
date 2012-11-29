$ ->
  $('.profile-url').keyup ->
      myText =$('.profile-url').val();
      $('.profile-url-dis').text(myText)

  $('.twitter-url').keyup ->
    myText =$('.twitter-url').val();
    $('.twitter-preview').text(myText)

  $('.facebook-url').keyup ->
    myText =$('.facebook-url').val();
    $('.facebook-preview').text(myText)

  $('.weibo-url').keyup ->
    myText =$('.weibo-url').val();
    $('.weibo-preview').text(myText)

  $('.appnet-url').keyup ->
    myText =$('.appnet-url').val();
    $('.appnet-preview').text(myText)


  $('.github-url').keyup ->
    myText =$('.github-url').val();
    $('.github-preview').text(myText)

  $('.flickr-url').keyup ->
    myText =$('.flickr-url').val();
    $('.flickr-preview').text(myText)


  $('.refresh-token').click ->
    $.ajax({
      url:'profile/renew_auth'
      type:'POST'
    }).done (responseText) ->
      $('.auth-token-display').text(responseText)
      $('.refresh-token').unbind('click');
      $('.refresh-token').removeClass('icon-refresh').addClass(' icon-ok-sign')

  getCallback = () ->
    switch (window.location.hostname)
      when "127.0.0.1" then return "http://127.0.0.1:3000/soundcloud_oauth_callback.html"
      when "ocelots-staging.herokuapp.com" then return "http://ocelots-staging.herokuapp.com/soundcloud_oauth_callback.html"
      when "iocelots.com" then return "http://iocelots.com/soundcloud_oauth_callback.html"

  getClientID = () ->
    switch (window.location.hostname)
      when "127.0.0.1" then return "ee3d987c0fa30e22edd251a7bd046851"
      when "ocelots-staging.herokuapp.com" then return "40d2c306162dcea94436672679aa6c25"
      when "iocelots.com" then return "bdb756070f00205c76a9563eafe8ca09"

  SC.initialize {
    client_id: getClientID()
    redirect_uri: getCallback()
  }

  $("#recorderUI.reset #controlButton").live "click", (e) ->
    updateTimer 0
    SC.record {
    start:() ->
      setRecorderUIState("recording")
      $('#timer').removeClass("hidden")
    progress: (ms, avgPeak) ->
      updateTimer ms
    }
    e.preventDefault

  $("#recorderUI.recording #controlButton, #recorderUI.playing #controlButton").live "click", (e) ->
    setRecorderUIState "recorded"
    SC.recordStop
    e.preventDefault

  $("#recorderUI.recorded #controlButton").live "click", (e) ->
    updateTimer 0
    setRecorderUIState "playing"
    SC.recordPlay {
      progress: (ms) ->
        updateTimer ms
      finished: () ->
        setRecorderUIState "recorded"
    }
    e.preventDefault

  $("#reset").live "click", (e) ->
    SC.recordStop
    setRecorderUIState "reset"
    e.preventDefault

  $("#upload").live "click", (e) ->
    setRecorderUIState "uploading"
    SC.connect {
      connected: () ->
        $("#uploadStatus").html "Uploading..."
        SC.recordUpload {
          track: {
            title: $('#full_name').val() + ".voice",
            sharing: "public"
          }
        }, (track) ->
          $("#uploadStatus").html("Upload Success!<br>Please update your profile");
          $('#track').val(track.id)
          $('#secret').val(track.secret_token)
    }
    e.preventDefault

  updateTimer = (ms) ->
    $("#timer").text(SC.Helper.millisecondsToHMS(ms))

  setRecorderUIState = (state) ->
    $("#recorderUI").attr("class", state)


