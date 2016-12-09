# == Schema Information
#
# Table name: prosecutors_offices
#
#  id         :integer          not null, primary key
#  full_name  :string
#  name       :string
#  court_id   :integer
#  is_hidden  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin::ProsecutorsOffice < ProsecutorsOffice
  validates :full_name, :name, uniqueness: true
  validates :court, :full_name, presence: true
end
