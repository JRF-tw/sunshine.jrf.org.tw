prev = (class_name) -> """
  <button type='button' class='#{class_name}__prev appearance-none'>
    <svg class='icon'><use xlink:href='#icon-arrow-next' /></svg>
  </button>
"""

next = (class_name) -> """
  <button type='button' class='#{class_name}__next appearance-none'>
    <svg class='icon'><use xlink:href='#icon-arrow-next' /></svg>
  </button>
"""

module.exports =
  prev: prev
  next: next
