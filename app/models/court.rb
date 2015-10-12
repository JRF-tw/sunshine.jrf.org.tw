# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  court_type :string(255)
#  full_name  :string(255)
#  name       :string(255)
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

class Court < ActiveRecord::Base
  include HiddenOrNot
  has_many :judgments

  def self.judges
    where(court_type: "法院")
  end

  def self.prosecutors
    where(court_type: "檢察署")
  end

  scope :newest, ->{ order("id DESC") }
end
