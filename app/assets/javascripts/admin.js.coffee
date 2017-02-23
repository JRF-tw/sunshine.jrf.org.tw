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
  select = $('.rater-name select')
  change_rater_select = ->
    select.find('option').remove()
    select.append $('<option></option>').attr('value', '').text('請選擇')
    select.val('').trigger 'change'
    selected = $('.rater-type select').find(':selected').attr('data-role-names')
    if selected
      option = JSON.parse(selected)
    else
      option = []
    option.map (a) ->
      select.append $('<option></option>').attr('value', a[1]).text(a[0])

  $('.rater-type').change ->
    select.val([])
    select.select2('destroy')
    select.select2()
    change_rater_select()
  return
