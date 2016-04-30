# == Schema Information
#
# Table name: defendants
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  identify_number        :string           not null
#  phone_number           :string           not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :defendant do
    sequence(:name) { |n| "當事人 - #{n}"}
    password "12321313213"
    sequence(:identify_number) { |n| "A#{ rand(100000000..299999999) }" }
    sequence(:phone_number) { |n| "09#{ rand(1..99999999).to_s.rjust(8, '0') } " }
  end

end
