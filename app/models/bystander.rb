# == Schema Information
#
# Table name: bystanders
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
#

class Bystander < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone_number, uniqueness: true, format:{ with: /\A(0)(9)([0-9]{8})\z/ }, allow_nil: true
end
