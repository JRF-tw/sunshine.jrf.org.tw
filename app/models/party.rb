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
#  imposter                 :boolean          default(FALSE)
#  imposter_identify_number :string
#  phone_confirmed_at       :datetime
#  unconfirmed_phone        :string
#

class Party < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  has_many :schedule_scores, as: :schedule_rater
  has_many :verdict_scores, as: :verdict_rater
  has_many :valid_scroes, as: :score_rater

  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  devise authentication_keys: [:identify_number]

  validates :name, presence: true
  validates :identify_number, presence: true, uniqueness: true, format: { with: /\A[A-Z]{1}[1-2]{1}[0-9]{8}\z/, message: '身分證字號格式不符(英文字母請大寫)' }
  validates :phone_number, uniqueness: true, format: { with: /\A(0)(9)([0-9]{8})\z/ }, allow_nil: true
  validates :unconfirmed_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_nil: true

  has_many :story_relations, as: :people
  has_many :story_subscriptions, as: :subscriber, dependent: :destroy
  has_many :verdict_relations, as: :person

  include Redis::Objects
  value :delete_phone_job_id
  value :phone_varify_code, expiration: 1.hour
  counter :retry_verify_count, expiration: 1.hour
  counter :sms_sent_count, expiration: 5.minutes
  counter :score_report_schedule_real_date
  counter :scored_count

  MAX_SCORED_COUNT = 2

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
    phone_confirmed_at.present?
  end

  def set_reset_password_token
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end

  def unsubscribe_token
    Digest::MD5.hexdigest(self.class.name + email + Setting.unsubscribe_key)
  end
end
