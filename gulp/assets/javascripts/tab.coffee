module.exports = ->
  class SearchTab
    constructor: (@toggle) ->
      @content = $(@toggle.data('content'))
      @init()

    init: ->
      @content.not(':first-child').hide()
      
      @toggle.on 'click', (e) =>
        unless $(e.currentTarget).hasClass 'active'
          @toggle.parent().siblings().removeClass 'active'
                 .end().addClass 'active'
          @content.siblings().hide()
                  .end().show()

  $('.search-tab__cell').each ->
    new SearchTab $(@)