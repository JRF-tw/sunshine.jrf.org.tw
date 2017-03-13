# == Schema Information
#
# Table name: crawler_logs
#
#  id                 :integer          not null, primary key
#  crawler_history_id :integer
#  crawler_kind       :integer
#  crawler_error_type :integer
#  crawler_errors     :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :crawler_log do
    crawler_history { create :crawler_history }
    crawler_kind :crawler_court
    crawler_error_type :parse_data_failed

    trait :judge_parse_error do
      crawler_kind :crawler_referee
      crawler_error_type :parse_judge_error
      sequence(:crawler_errors) { |n| Array.new(10, "法官抓取格式錯誤 - #{n}") }
    end
  end
end
