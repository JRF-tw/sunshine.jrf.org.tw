# Require Stylesheets
require "stylesheets"

# Require Modernizr
require "modernizr"

# Require Lazysizes
require "lazysizes/plugins/custommedia/ls.custommedia"
require "lazysizes/plugins/respimg/ls.respimg"
require "lazysizes"
# Require Custom Modules
# EX:
# { MainMenu } = require "./modules/sidebar"
Modal = require "./modules/modal"

# Require entry modules
# EX:
# { HomeBanners, HomeCover } = require "./entry/home"

# Inject SVG Sprite
sprites = require.context "icons", off
sprites.keys().forEach sprites

$(document).on "page:change", ->
  # Async apply Typekit
  `
  try{Typekit.load({ async: true });}catch(e){}
  `

  # EX:
  # new MainMenu()
  # new HomeBanners()
  # new HomeCover()
