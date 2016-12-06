#= require select2

$(document).ready ->
  $('.select2 select').select2( { placeholder: '請選擇', allowClear: true }  )
  $('select.select2').select2( { placeholder: '請選擇', allowClear: true }  )
return
