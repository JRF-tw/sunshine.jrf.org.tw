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

class Lawyer < ActiveRecord::Base
  has_many :lawyer_verdicts
  has_many :verdicts, through: :lawyer_verdicts

  validates_presence_of :name
  mount_uploader :avatar, ProfileAvatarUploader
end
