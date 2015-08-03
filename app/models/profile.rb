# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  current            :string(255)
#  avatar             :string(255)
#  gender             :string(255)
#  gender_source      :string(255)
#  birth_year         :integer
#  birth_year_source  :string(255)
#  stage              :integer
#  stage_source       :string(255)
#  appointment        :string(255)
#  appointment_source :string(255)
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#

class Profile < ActiveRecord::Base

  has_many :educations, :dependent => :destroy
  has_many :careers, :dependent => :destroy
  has_many :licenses, :dependent => :destroy
  has_many :awards, :dependent => :destroy
  has_many :punishments, :dependent => :destroy
  
end
