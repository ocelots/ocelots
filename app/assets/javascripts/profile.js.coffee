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
