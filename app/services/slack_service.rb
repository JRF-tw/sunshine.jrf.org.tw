class SlackService
  WEBHOOK = "https://hooks.slack.com/services/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".freeze
  DEFAULT_ICON_URL = "http://i.imgur.com/kwu9VJF.jpg".freeze

  class << self
    def notify(message, channel: "#general", name: "slack-robot", icon_url: DEFAULT_ICON_URL, webhook: nil)
      name = "slack-robot" if name.blank?
      icon_url = DEFAULT_ICON_URL if icon_url.blank?
      notify = Slack::Notifier.new(webhook || WEBHOOK, channel: channel, username: name)
      message = "[#{Rails.env}] #{message}" unless Rails.env.production?
      notify.ping(message, icon_url: icon_url)
    end

    def notify_async(message, channel: "#general", name: "slack-robot", icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook)
    end
  end

end
