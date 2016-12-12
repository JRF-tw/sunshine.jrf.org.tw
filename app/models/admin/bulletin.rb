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

class Admin::Bulletin < ::Bulletin
  validates :title, presence: true
  validates :content, presence: true
  validates :is_banner, exclusion: { in: [true], message: '需要有標題以及圖片才能設定' }, unless: :can_be_banner?
  mount_uploader :pic, BulletinPicUploader

end
