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
#

class CourtObserver < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :schedule_scores, as: :schedule_rater
  has_many :valid_scroes, as: :score_rater
  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :phone_number, uniqueness: true, format: { with: /\A(0)(9)([0-9]{8})\z/ }, allow_blank: true, allow_nil: true

  include Redis::Objects
  counter :score_report_schedule_real_date
end
