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

class Admin::Bulletin < ::Bulletin
  validates :title, presence: true
  validates :content, presence: true

end
