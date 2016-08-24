class Toggle
  constructor: (@query) ->
    $(@query).on 'click', (e) =>
      $this = $(e.currentTarget)
      on_targets  = $this.data('switch-on')
      off_targets = $this.data('switch-off')

      @enable on_targets if on_targets? 
      @disable off_targets if off_targets?

  enable: (targets) ->
    if targets.length > 1
      $(target).addClass 'active' for target in targets
    else
      $(targets).addClass 'active'

  disable: (targets) ->
    if targets.length > 1
      $(target).removeClass 'active' for target in targets
    else
      $(targets).removeClass 'active'

class Dismiss
  constructor: (@query) ->

  init: ->
    $(@query).on 'click', (e) ->
      $this = $(@)
      switch $this.data 'dismiss'
        when 'alert' then $this.parent().slideUp()

module.exports =
  Toggle: Toggle
  Dismiss: Dismiss