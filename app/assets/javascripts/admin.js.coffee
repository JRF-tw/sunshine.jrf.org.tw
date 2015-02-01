#= require jquery
#= require jquery_ujs
#= require datetimepicker
#= require nested_form
#= require bootstrap
#= require unicorn
#= require_self

# admin menu auto active
$ ->
  $("li.submenu li.active").each ->
    $(this).parents("li.submenu").addClass("open active")
