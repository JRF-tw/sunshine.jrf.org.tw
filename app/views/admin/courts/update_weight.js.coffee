$(".js-weight-updated-refresh").html("<%= j(render 'update_weight', loacl: { courts: @courts } ) %>")
<% if @error_messages %>
  dom.append('<div class="error-messages"><%= j(render_html(@error_messages.join("\n"))) %></div>')
<% end %>
