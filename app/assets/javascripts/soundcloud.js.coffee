$ ->
  getCallback = () ->
    switch (window.location.hostname)
      when "127.0.0.1" then "http://127.0.0.1:3000/soundcloud_oauth_callback.html"
      when "ocelots-staging.herokuapp.com" then "http://ocelots-staging.herokuapp.com/soundcloud_oauth_callback.html"
      when "iocelots.com" then "http://iocelots.com/soundcloud_oauth_callback.html"

  getClientID = () ->
    switch (window.location.hostname)
      when "127.0.0.1" then "ee3d987c0fa30e22edd251a7bd046851"
      when "ocelots-staging.herokuapp.com" then "40d2c306162dcea94436672679aa6c25"
      when "iocelots.com" then "bdb756070f00205c76a9563eafe8ca09"

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
    SC.recordStop()
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