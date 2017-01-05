# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  full_name  :string
#  name       :string
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean          default(TRUE)
#  code       :string
#  scrap_name :string
#  court_type :string
#

class Admin::Court < ::Court
  has_many :judgments, class_name: 'Admin::Judgment'

  validates :full_name, presence: true
  validates :full_name, :name, uniqueness: true

end
