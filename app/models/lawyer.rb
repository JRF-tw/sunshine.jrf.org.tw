# == Schema Information
#
# Table name: lawyers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  current    :string
#  avatar     :string
#  gender     :string
#  birth_year :integer
#  memo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lawyer < ActiveRecord::Base
  has_many :lawyer_verdicts
  has_many :verdicts, through: :lawyer_verdicts
  has_many :story_relations, as: :people
  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  mount_uploader :avatar, ProfileAvatarUploader

  def need_update_info?
    !current
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def check_lawyer_exist_and_not_active
  end
end
