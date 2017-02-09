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

$ ->
  change_rater_select = ->
    $('.rater-name select').find('option').remove()
    option = JSON.parse($('.rater-type select').find(':selected').attr('data'))
    $('.rater-name select').append $('<option></option>').attr('value', '').text('請選擇')
    option.map (a) ->
      $('.rater-name select').append $('<option></option>').attr('value', a[1]).text(a[0])
    return
  change_rater_select()

  $('.rater-type').change ->
    change_rater_select()
  return
