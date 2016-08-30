form = $(".js-subscribe-edm")
form.html('<%= raw render(partial: "court_observers/edms/subscribe_edm") %>')
<% if @error_messages %>
form.append('<div class="error-messages"><%= j(render_html(@error_messages.join("\n"))) %></div>')
<% end %>

