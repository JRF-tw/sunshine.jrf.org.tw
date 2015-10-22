module.exports = ->
  
  class SuitProcedureAccordion
    constructor: (@button) ->
      @list = @button.parent().find('.list--suit-process__cell')
      @rest_list = @list.not(':last-child')

      @default = @button.data 'default'
      
      @button.on 'click', (e) =>
        if $(e.currentTarget).hasClass 'close'
          @close()
        else
          @open()
        false

      @init()

    open: ->
      @rest_list.slideDown 300
      @change_method 'close'

    close: ->
      @rest_list.slideUp 300
      @change_method 'open'

    change_method: (order) ->
      unless order is 'open'
        @button.removeClass 'open'
               .addClass 'close'
               .text '關閉'
      else
        @button.removeClass 'close'
               .addClass 'open'
               .text '展開'

    init: ->
      if @list.length <= 1
        @button.remove()
        @list.css {"border-bottom": "none"}

      else
        unless @default is 'open'
          @change_method 'close'
        else
          @change_method 'open'
          @rest_list.hide()

  $('.list--suit-process-toggle').each ->
    new SuitProcedureAccordion $(@)
