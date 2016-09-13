form = $(".js-subscribe-edm")
error_dom = $(".billboard__alert")
checkbox_dom = $("input[name=subscribe_edm]")

if form.length
  form.html('<%= raw render(partial: "lawyers/edms/subscribe_edm") %>')

<% if @error_messages %>
error_dom.html("")
error_dom.append('<div class="alert alert--error"><%= j(render_html(@error_messages.join("\n"))) %></div>')
if checkbox_dom.length
  checkbox_dom.prop("checked", false)
<% end %>



