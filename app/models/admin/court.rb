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
#  is_hidden  :boolean
#  code       :string
#

class Admin::Court < ::Court
  has_many :judgments, class_name: "Admin::Judgment"

  validates_presence_of :court_type, :full_name
  validates_uniqueness_of :full_name, :name

  def self.get_courts
    where(court_type: "法院")
  end

  def self.prosecutors
    where(court_type: "檢察署")
  end

  def display_type
    return "是" if self.is_hidden
    "否"
  end  
end
