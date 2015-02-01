#= require jquery-ui/datepicker
#= require jquery-ui/slider
#= require jquery.timepicker

$(document).ready ->
  $('[data-datepicker]').datepicker dateFormat: 'yy-mm-dd'
  return
$(document).ready ->
  $('[data-datetimepicker]').each ->
    # more options: http://trentrichardson.com/examples/timepicker/
    $(this).datetimepicker
      dateFormat: 'yy-mm-dd'
      hourGrid: 4
      minuteGrid: 10
      stepMinute: 10
    return
  return
