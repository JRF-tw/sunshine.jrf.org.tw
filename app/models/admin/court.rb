# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  court_type :string
#  full_name  :string
#  name       :string
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean          default(TRUE)
#  code       :string
#  scrap_name :string
#

class Admin::Court < ::Court
  has_many :judgments, class_name: "Admin::Judgment"

  validates :court_type, :full_name, presence: true
  validates :full_name, :name, uniqueness: true

  def self.get_courts
    where(court_type: "法院")
  end

  def self.prosecutors
    where(court_type: "檢察署")
  end

end
