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
  validates_presence_of :name
  mount_uploader :avatar, ProfileAvatarUploader

end
