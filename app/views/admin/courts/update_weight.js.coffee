$(".dataTables_wrapper").html("<%= j(render :file => 'admin/courts/edit_weight', object: @courts) %>")
<% if @error_messages %>
  dom.append('<div class="error-messages"><%= j(render_html(@error_messages.join("\n"))) %></div>')
<% end %>
