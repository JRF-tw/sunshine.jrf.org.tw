module.exports = ->
  class MobileNav
    constructor: (@nav, @toggle) ->
      @nav.hide()
      @toggle.on 'click', (e) =>
        $(e.currentTarget).toggleClass 'active'
        @nav.slideToggle 300
        false
      
  new MobileNav $('#mb-nav'), $('#mb-nav-toggle')