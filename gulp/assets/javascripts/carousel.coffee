module.exports = ->
  # $('#base-carousel').owlCarousel
  #   items: 1
  #   loop: true
  #   dots: false
  #   autoplay: true
  #   autoplayTimeout: 3000
  #   animateOut: 'fadeOut'

  $('#hero-carousel').slick
    dots: false
    infinite: true
    speed: 300
    fade: true
    cssEase: 'linear'
    adaptiveHeight: false
    slidesToShow: 1
    autoplay: true
    autoplaySpeed: 3000
    arrows: false

  $('#carousel').slick
    dots: true
    infinite: true
    speed: 300
    fade: true
    cssEase: 'linear'
    adaptiveHeight: false
    slidesToShow: 1
    autoplay: true
    autoplaySpeed: 8000
    arrows: false