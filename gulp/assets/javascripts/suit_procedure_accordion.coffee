module.exports = ->
  
  class SuitProcedureAccordion
    constructor: (@button) ->
      @lists = @button.prev('.list--suit-process')
                      .children(':not(:last-child)')

      @default = @button.data 'default'
      
      @button.on 'click', (e) =>
        if $(e.currentTarget).hasClass 'close'
          @close()
        else
          @open()
        false

      @init()

    open: =>
      @lists.slideDown 300
      @change_method 'close'

    close: =>
      @lists.slideUp 300
      @change_method 'open'

    change_method: (order) =>
      unless order is 'open'
        @button.removeClass 'open'
               .addClass 'close'
               .text 'CLOSE'
      else
        @button.removeClass 'close'
               .addClass 'open'
               .text 'OPEN'

    init: =>
      unless @default is 'open'
        @change_method 'close'
      else
        @change_method 'open'
        @lists.hide()

  $('.list--suit-process-toggle').each ->
    new SuitProcedureAccordion $(@)