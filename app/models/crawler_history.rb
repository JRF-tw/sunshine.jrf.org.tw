# == Schema Information
#
# Table name: crawler_histories
#
#  id              :integer          not null, primary key
#  scrap_at        :date
#  courts_count    :integer          default(0), not null
#  branches_count  :integer          default(0), not null
#  judges_count    :integer          default(0), not null
#  verdicts_count  :integer          default(0), not null
#  schedules_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CrawlerHistory < ActiveRecord::Base
  validates :scrap_at, presence: true
end
