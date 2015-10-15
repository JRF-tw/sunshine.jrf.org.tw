# == Schema Information
#
# Table name: suits
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  summary    :text
#  content    :text
#  state      :string(255)
#  pic        :string(255)
#  suit_no    :integer
#  keyword    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

class Admin::Suit < ::Suit

  has_many :suit_judges, dependent: :destroy
  has_many :judges, class_name: "Admin::Profile", through: :suit_judges
  has_many :suit_prosecutors, dependent: :destroy
  has_many :prosecutors, class_name: "Admin::Profile", through: :suit_prosecutors
  has_many :procedures, class_name: "Admin::Procedure", dependent: :destroy

  validates_presence_of :title, :state
end
