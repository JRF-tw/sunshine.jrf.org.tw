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

  validates_presence_of :name, :email
  mount_uploader :avatar, ProfileAvatarUploader

  def need_update_info?
    !current
  end

  def password_required?
    super if confirmed?
  end

  def status
    confirmed? ? "已註冊" : "未註冊"
  end

end
