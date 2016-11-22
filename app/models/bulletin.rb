# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  is_banner  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bulletin < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :is_banner, exclusion: { in: [true], message: '需要有標題以及圖片才能設定' }, unless: :can_be_banner?
  mount_uploader :pic, BulletinPicUploader

  scope :shown, -> { where(is_banner: true) }
  scope :most_recent, -> { order(created_at: :desc).limit(3) }

  def can_be_banner?
    title && pic.present?
  end
end
