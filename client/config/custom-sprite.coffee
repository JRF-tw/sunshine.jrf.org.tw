Sprite = require('svg-sprite-loader/lib/web/sprite')
globalSprite = new Sprite()

inject_sprite = ->
  globalSprite.elem = globalSprite.render document.body

document.addEventListener 'DOMContentLoaded', inject_sprite, off
document.addEventListener 'page:load', inject_sprite, off

module.exports = globalSprite