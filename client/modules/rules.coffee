Cookies = require 'js-cookie'

class Rules
  constructor: () ->
    $(document).on 'click', '#appeal-to-schedule', (e) =>
      @check_cookie e, 'schedule'

    $(document).on 'click', '#appeal-to-verdict', (e) =>
      @check_cookie e, 'verdict'

    $(document).on 'click', '#confirmed-schedule-rules', (e) =>
      @set_cookie_and_go e, 'schedule'

    $(document).on 'click', '#confirmed-verdict-rules', (e) =>
      @set_cookie_and_go e, 'verdict'

  check_cookie: (e, type) ->
    e.preventDefault()
    role = $(e.target).data 'role'

    if Cookies.get("#{role}_has_seen_#{type}_rules")
      Turbolinks.visit e.target.href
    else
      Turbolinks.visit "/#{role}/score/#{type}s/rule"

  set_cookie_and_go: (e, type) ->
    e.preventDefault()
    role = $(e.target).data 'role'

    Cookies.set "#{role}_has_seen_#{type}_rules", true, { expires: 7 }
    Turbolinks.visit e.target.href
    
module.exports = Rules