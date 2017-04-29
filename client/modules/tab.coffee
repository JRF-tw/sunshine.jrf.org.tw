export default class Tab
  constructor: (@query) ->
    $(document).on "click", @query, (e) =>
      $this = $(e.currentTarget)

      unless $this.hasClass 'active'
        @update_active $this
        @update_active $($this.data('tab-content'))

  update_active: (el) ->
    el.addClass 'active'
      .siblings().removeClass 'active'
