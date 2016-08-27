class Collapse
  constructor: (@query) ->
    $toggle = $(@query)
    $toggle_wrapper = $toggle.parent()
    $toggle_target  = $($toggle.data('collapse'))

    $toggle_target.hide()

    $toggle.on 'click', (e) ->
      $toggle.toggleClass 'active'
      $toggle_wrapper.toggleClass 'extracted'
      $toggle_target.slideToggle 300

module.exports = Collapse