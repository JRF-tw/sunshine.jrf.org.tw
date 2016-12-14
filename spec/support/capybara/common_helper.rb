module Capybara
  module CommonHelper
    def manual_http_request(method, path)
      page.execute_script("$.ajax({url: '#{path}', data: {}, type: '#{method}'});")
      # Wait for the request to finish executing...
      Timeout.timeout(10) { loop until page.evaluate_script('jQuery.active').zero? }
    end

    def select_from_chosen(item_text, options)
      field = find_field(options[:from], visible: false)
      option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
      page.execute_script("value = ['#{option_value}']\; if ($('##{field[:id]}').val()) {$.merge(value, $('##{field[:id]}').val())}")
      option_value = page.evaluate_script('value')
      page.execute_script("$('##{field[:id]}').val(#{option_value})")
      page.execute_script("$('##{field[:id]}').trigger('liszt:updated').trigger('change')")
    end

    def open_last_email(email)
      perform_sidekiq_job(fetch_sidekiq_last_job)
      open_email(email)
    end
  end
end
