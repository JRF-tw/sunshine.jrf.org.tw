module.exports = ->
  $("html").addClass "no-css-appearance" unless Modernizr.testAllProps "appearance"