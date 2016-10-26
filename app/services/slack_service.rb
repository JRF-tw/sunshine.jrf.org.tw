class SlackService
  WEBHOOK = 'https://hooks.slack.com/services/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'.freeze
  DEFAULT_ICON_URL = 'http://i.imgur.com/kwu9VJF.jpg'.freeze
  DISABLED_ENV = ['staging'].freeze

  class << self
    def notify(message, channel: '#general', name: 'slack-robot', icon_url: DEFAULT_ICON_URL, webhook: nil)
      name = 'slack-robot' if name.blank?
      icon_url = DEFAULT_ICON_URL if icon_url.blank?
      notify = Slack::Notifier.new(webhook || WEBHOOK, channel: channel, username: name)
      message = "[#{Rails.env}] #{message}" unless Rails.env.production?
      notify.ping(message, icon_url: icon_url)
    end

    def notify_async(message, channel: '#general', name: 'slack-robot', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
    end

    def notify_scrap_court_alert(message, channel: '#notify-scrap-error', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
      false
    end

    def notify_new_story_type_alert(message, channel: '#notify-scrap-analysis', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
    end

    def notify_analysis_schedule_alert(message, channel: '#notify-scrap-analysis', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
    end

    def notify_scrap_daily_alert(message, channel: '#notify-scrap-daily', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
    end

    def notify_court_alert(message, channel: '#notify-court', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
    end

    def notify_branch_alert(message, channel: '#notify-branch', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
    end

    def notify_create_highest_judge_alert(message, channel: '#notify-verdict', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless DISABLED_ENV.include?(Rails.env)
    end

    def notify_sms_alert(message, channel: '#notify-sms', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook) unless Rails.env == 'production'
    end

    def notify_report_schedule_date_over_range_alert(message, channel: '#notify-developer', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook)
    end

    def notify_scored_time_over_range_alert(message, channel: '#notify-developer', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook)
    end

    def notify_user_activity_alert(message, channel: '#notify-user-activity', name: 'notify', icon_url: DEFAULT_ICON_URL, webhook: nil)
      delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook)
    end

    def render_link(link, message = nil)
      message ||= link
      "<#{link}|#{message}>"
    end
  end
end
