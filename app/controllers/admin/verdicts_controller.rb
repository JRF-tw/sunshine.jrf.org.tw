# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  is_judgment      :boolean
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#

class Admin::VerdictsController < Admin::BaseController
  before_action :verdict

  def index
    @search = Verdict.all.newest.ransack(params[:q])
    @verdicts = @search.result.page(params[:page]).per(20)
    @admin_page_title = "判決書列表"
    add_crumb @admin_page_title, "#"
  end

  def download_file
    @file_url = Rails.env.development? || Rails.env.test? ? @verdict.file.path : @verdict.file.url.gsub("//", "http://")
    data = open(@file_url).read
    send_data data, disposition: 'attachment', filename: "verdict-#{@verdict.id}.html"
  end

  private

  def verdict
    @verdict ||= params[:id] ? Verdict.find(params[:id]) : Verdict.new
  end
end
