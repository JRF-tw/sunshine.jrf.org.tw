# == Schema Information
#
# Table name: lawyers
#
#  id         :integer          not null, primary key
#  name       :string
#  current    :string
#  avatar     :string
#  gender     :string
#  birth_year :integer
#  memo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Admin::Lawyer < ::Lawyer
  has_many :lawyer_stories
  has_many :stories, through: :lawyer_stories

  validates_presence_of :name
  mount_uploader :avatar, ProfileAvatarUploader

  GENDER_TYPES = [
    "男",
    "女",
    "其他"
  ]
end
