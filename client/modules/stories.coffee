export class StoryInjection
  constructor: (@query) ->
    $(document).on "ready page:load", =>
      $container = $(@query)

      $.getJSON $container.data("story-inject"), (res) =>
        filteredContent = getReJDocString res.main_content

        $container
        .html filteredContent
        .removeClass "hidden"
        .next ".loading"
        .remove()

export class Collapse
  constructor: (@query) ->
    $(document).on 'page:change', =>
      @toggle = $(@query)
      @toggle_wrapper = @toggle.parent()
      @toggle_target  = $(@toggle.data('collapse'))

    $(document).on 'click', @query, (e) =>
      @toggle.toggleClass 'active'
      @toggle_wrapper.toggleClass 'extracted'
      @toggle_target.slideToggle 300
