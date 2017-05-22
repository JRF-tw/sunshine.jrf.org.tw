# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string
#  content    :text
#  start_at   :date
#  end_at     :date
#  source     :text
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#  owner_id   :integer
#  owner_type :string
#

class Education < ActiveRecord::Base
  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :start_at, :end_at

  belongs_to :owner, polymorphic: true
  belongs_to :profile
  validates :owner_id, :owner_type, :title, presence: true

  scope :newest, -> { order('id DESC') }
  scope :order_by_end_at, -> { order('end_at DESC, id DESC') }
end
