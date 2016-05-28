# == Schema Information
#
# Table name: suits
#
#  id              :integer          not null, primary key
#  title           :string
#  summary         :text
#  content         :text
#  state           :string
#  pic             :string
#  suit_no         :integer
#  keyword         :string
#  created_at      :datetime
#  updated_at      :datetime
#  is_hidden       :boolean
#  procedure_count :integer          default(0)
#

class Admin::Suit < ::Suit

  has_many :suit_judges, dependent: :destroy
  has_many :judges, class_name: "Admin::Profile", through: :suit_judges
  has_many :suit_prosecutors, dependent: :destroy
  has_many :prosecutors, class_name: "Admin::Profile", through: :suit_prosecutors
  has_many :procedures, class_name: "Admin::Procedure", dependent: :destroy

  validates_presence_of :title, :state
end
