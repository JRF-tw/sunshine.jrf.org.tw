#= require jquery
#= require jquery_ujs
#= require datetimepicker
#= require nested_form
#= require bootstrap
#= require unicorn
#= require chosen-jquery
#= require redactor-rails
#= require redactor-rails/plugins
#= require redactor-rails/plugins/inlinestyle
#= require redactor-rails/plugins/source
#= require redactor-rails/langs/zh_tw
#= require_self

# admin menu auto active
$ ->
  $("li.submenu li.active").each ->
    $(this).parents("li.submenu").addClass("open active")

$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: '沒有符合的搜尋結果'