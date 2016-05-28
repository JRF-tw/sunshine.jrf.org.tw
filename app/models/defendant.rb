# == Schema Information
#
# Table name: defendants
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  identify_number        :string           not null
#  phone_number           :string
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

class Defendant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :authentication_keys => [ :identify_number ]

  has_many :defendant_verdicts
  has_many :verdicts, through: :defendant_verdicts
  has_many :story_relations, as: :people

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
