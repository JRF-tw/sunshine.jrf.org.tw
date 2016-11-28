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
  has_many :story_subscriptions, as: :subscriber, dependent: :destroy
  has_many :schedule_scores, as: :schedule_rater
  has_many :verdict_scores, as: :verdict_rater
  has_many :valid_scroes, as: :score_rater

  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :email, presence: true
  mount_uploader :avatar, AvatarUploader

  validates :phone_number, uniqueness: true, format: { with: /\A(0)(9)([0-9]{8})\z/ }, allow_blank: true, allow_nil: true
  validates :office_number, format: { with: /0\d{1,2}-?(\d{6,8})(#\d{1,5}){0,1}/ }, allow_blank: true, allow_nil: true

  before_create :skip_confirmation_notification

  include Redis::Objects
  counter :score_report_schedule_real_date
  counter :scored_count

  MAX_SCORED_COUNT = 5

  def need_update_info?
    ## TODO need_update_info definition logic
    !phone_number
  end

  def password_required?
    super if confirmed? || reset_password_token
  end

  def set_reset_password_token
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end

  def set_confirmation_token
    if confirmation_token && !confirmation_period_expired?
      @raw_confirmation_token = confirmation_token
    else
      raw, = Devise.token_generator.generate(self.class, :confirmation_token)
      self.confirmation_token = @raw_confirmation_token = raw
      self.confirmation_sent_at = Time.now.utc
    end
  end

  def unsubscribe_token
    Digest::MD5.hexdigest(self.class.name + email + Setting.unsubscribe_key)
  end

  private

  def skip_confirmation_notification
    skip_confirmation_notification!
  end

end
