class Admin::RulesController < Admin::BaseController
  before_action :rule
  before_action(except: [:index]) { add_crumb('裁定列表', admin_rules_path) }

  def index
    @search = Rule.includes(story: :court).newest.ransack(params[:q])
    @rules = @search.result.includes(:story).page(params[:page]).per(20)
    @story = Story.includes(:court).find_by(id: params[:q][:story_id_eq]) if params[:q]
    @search_form_title = @story ? @story.detail_info + ' 裁定列表' : '裁定列表'
    @admin_page_title = '裁定列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "#{@rule.story.court.name}-#{@rule.story.identity} - 裁定"
    add_crumb @admin_page_title, '#'
  end

  def download_file
    @file_url = Rails.env.development? || Rails.env.test? ? @rule.file.path : @rule.file.url.gsub('//', 'http://')
    data = open(@file_url).read
    send_data data, disposition: 'attachment', filename: "rule-#{@rule.id}.html"
  end

  private

  def rule
    @rule ||= params[:id] ? Rule.find(params[:id]) : Rule.new
  end
end
