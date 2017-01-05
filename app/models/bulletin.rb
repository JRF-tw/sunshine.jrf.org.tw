# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bulletin < ActiveRecord::Base
  mount_uploader :pic, BulletinPicUploader
  scope :most_recent, -> (amount) { order(created_at: :desc).limit(amount) }
end
