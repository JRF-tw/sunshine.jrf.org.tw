# == Schema Information
#
# Table name: parties
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  identify_number          :string           not null
#  phone_number             :string
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string
#  last_sign_in_ip          :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  email                    :string
#  unconfirmed_email        :string
#  confirmed_at             :datetime
#  confirmation_token       :string
#  confirmation_sent_at     :datetime
#  phone_confirmed_at       :datetime
#  imposter                 :boolean          default(FALSE)
#  imposter_identify_number :string
#

class Party < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  devise authentication_keys: [ :identify_number ]

  validates :name, presence: true
  validates :identify_number, presence: true, uniqueness: true, format: { with: /\A[A-Z]{1}[1-2]{1}[0-9]{8}\z/, message: "身分證字號格式不符(英文字母請大寫)" }
  validates :phone_number, uniqueness: true, format:{ with: /\A(0)(9)([0-9]{8})\z/ }, allow_nil: true

  has_many :story_relations, as: :people
  has_many :verdict_relations, as: :person

  include Redis::Objects
  value :unconfirmed_phone, expiration: 1.hour
  value :phone_varify_code, expiration: 1.hour
  counter :retry_verify_count, expiration: 1.hour
  counter :sms_sent_count, expiration: 5.minute

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def confirmation_required?
    false
  end

  def phone_confirm!
    update_attributes(phone_confirmed_at: Time.now)
  end

  def phone_unconfirm!
    update_attributes(phone_confirmed_at: nil)
  end

  def phone_confirmed?
    !!phone_confirmed_at
  end

  def set_reset_password_token
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    self.save(validate: false)
    raw
  end
end