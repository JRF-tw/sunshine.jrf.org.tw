$(document).ready ->
  $('.disable-score').hover (->
    $('.disable-score .text').text("敬請期待")
    return
  ), ->
    $('.disable-score .text').text("評鑑報表")
    return
