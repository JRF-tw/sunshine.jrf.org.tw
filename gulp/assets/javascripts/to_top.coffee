module.exports = ->
  $to_top   = $('#to-top').hide()
  $document = $(window)
  
  $to_top.on 'click', ->
    $('html, body').animate
      scrollTop: 0
    , 500
    false

  $document.on 'scroll', $.throttle 1000 / 10, ->
    if $document.scrollTop() > 100
      $to_top.fadeIn 300
    else
      $to_top.fadeOut 300