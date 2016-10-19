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
    crawler_error_type :parse_date_failed
  end

end
