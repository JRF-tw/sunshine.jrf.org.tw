# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  is_hidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bulletin < ActiveRecord::Base
  include HiddenOrNot
  validates :title, presence: true
  validates :content, presence: true
  mount_uploader :pic, BulletinPicUploader
end
