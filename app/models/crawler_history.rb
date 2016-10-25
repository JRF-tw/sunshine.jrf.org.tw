# == Schema Information
#
# Table name: crawler_histories
#
#  id              :integer          not null, primary key
#  crawler_on      :date
#  courts_count    :integer          default(0), not null
#  branches_count  :integer          default(0), not null
#  judges_count    :integer          default(0), not null
#  verdicts_count  :integer          default(0), not null
#  schedules_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CrawlerHistory < ActiveRecord::Base
  validates :crawler_on, presence: true, uniqueness: true
  has_many :crawler_logs, dependent: :destroy
end
