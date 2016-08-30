# == Schema Information
#
# Table name: court_observers
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  phone_number           :string
#  school                 :string
#  student_number         :string
#  department_level       :string
#  last_scored_at         :date
#  subscribe_edm          :boolean          default(FALSE)
#

require "rails_helper"

RSpec.describe CourtObserver, type: :model do
  let(:court_observer) { create :court_observer }

  it "FactoryGirl" do
    expect(court_observer).not_to be_new_record
  end
end
