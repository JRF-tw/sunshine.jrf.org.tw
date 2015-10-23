module.exports = ->
  # $('#base-carousel').owlCarousel
  #   items: 1
  #   loop: true
  #   dots: false
  #   autoplay: true
  #   autoplayTimeout: 3000
  #   animateOut: 'fadeOut'
  $(document).on "page:change", ->
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
      fade: true
      dots: true
      infinite: true
      speed: 300
      cssEase: 'linear'
      adaptiveHeight: false
      slidesToShow: 1
      autoplay: true
      autoplaySpeed: 8000
      arrows: false

    window.profile_carousel = $('#profile-carousel')  
    if profile_carousel.length > 0
      profile_carousel.slick
        dots: true
        infinite: true
        speed: 300
        cssEase: 'linear'
        adaptiveHeight: false
        slidesToShow: 1
        autoplay: true
        autoplaySpeed: 8000
        arrows: false

  $(document).on "page:restore", ->
    if profile_carousel.length > 0 then profile_carousel.slick "refresh"