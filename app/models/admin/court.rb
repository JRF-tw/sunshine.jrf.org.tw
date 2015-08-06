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
#

class Admin::Court < ::Court
  validates_presence_of :court_type, :full_name
end
