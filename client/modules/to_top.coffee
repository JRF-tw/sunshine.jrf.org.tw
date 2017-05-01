export default class ToTop
  constructor: (@query) ->
    $to_top = $(@query)

    $to_top.on 'click', ->
      $('html, body').animate
        scrollTop: 0
      , 500
      false

    $(window).on 'scroll', ->
      requestAnimationFrame ->
        if $(window).scrollTop() > 100
          $to_top.addClass 'active'
        else
          $to_top.removeClass 'active'
