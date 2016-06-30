# == Schema Information
#
# Table name: lawyers
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  current                :string
#  avatar                 :string
#  gender                 :string
#  birth_year             :integer
#  memo                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  last_sign_in_at        :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  phone_number           :string
#  office_number          :string
#

class Lawyer < ActiveRecord::Base
  has_many :story_relations, as: :people
  has_many :verdict_relations, as: :person
  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :email
  mount_uploader :avatar, ProfileAvatarUploader

  validates :phone_number, uniqueness: true, format:{ with: /\A(0)(9)([0-9]{8})\z/ }, allow_nil: true
  # validates :office_number, uniqueness: true, format:{ with: /0\d{1,2}-?(\d{6,8})(#\d{1,5}){0,1}/ }, allow_nil: true

  def need_update_info?
    ## TODO 確認何謂個人資訊不足
    !phone_number
  end

  def password_required?
    super if confirmed?
  end

end
