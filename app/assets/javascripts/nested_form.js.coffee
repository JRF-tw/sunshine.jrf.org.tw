#= require jquery_nested_form
$(document).on 'nested:fieldAdded', (event) ->
  # this field was just inserted into your form
  field = event.field
  # it's a jQuery object already! Now you can find date input
  # var dateField = field.find('.date');
  # dateField.datepicker(); // and activate datepicker on it
  return
$(document).on 'nested:fieldRemoved', ->
  field = event.field
  return
