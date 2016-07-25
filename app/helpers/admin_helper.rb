module AdminHelper
  def admin_widget_box(title, icon: nil, &block)
    render partial: "admin/base/widget_box", locals: { main: capture(&block), title: title, icon: icon }
  end
end
