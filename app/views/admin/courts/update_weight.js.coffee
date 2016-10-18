$(".edit_court_table").html("<%= j(render 'edit_weight', loacl: { courts: @courts, page: @page } ) %>")
<% if @error_messages %>
  dom.append('<div class="error-messages"><%= j(render_html(@error_messages.join("\n"))) %></div>')
<% end %>
