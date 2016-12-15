#= require jquery
#= require jquery_ujs
#= require datetimepicker
#= require select2-js
#= require nested_form
#= require bootstrap
#= require unicorn
#= require chosen-jquery
#= require redactor-rails/redactor.min
#= require redactor-rails/plugins
#= require redactor-rails/langs/zh_tw
#= require redactor-rails/app_config
#= require ckeditor/init
#= require chartkick
#= require_self

# admin menu auto active
$ ->
  $("li.submenu li.active").each ->
    $(this).parents("li.submenu").addClass("open active")
