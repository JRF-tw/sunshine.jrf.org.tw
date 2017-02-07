# == Schema Information
#
# Table name: careers
#
#  id                  :integer          not null, primary key
#  profile_id          :integer
#  career_type         :string
#  old_unit            :string
#  old_title           :string
#  old_assign_court    :string
#  old_assign_judicial :string
#  old_pt              :string
#  new_unit            :string
#  new_title           :string
#  new_assign_court    :string
#  new_assign_judicial :string
#  new_pt              :string
#  start_at            :date
#  end_at              :date
#  publish_at          :date
#  source              :text
#  source_link         :text
#  origin_desc         :text
#  memo                :text
#  created_at          :datetime
#  updated_at          :datetime
#  is_hidden           :boolean
#  owner_id            :integer
#  owner_type          :string
#

class Career < ActiveRecord::Base
  include HiddenOrNot
  include TaiwanAge
  tw_age_columns :publish_at, :start_at, :end_at

  belongs_to :owner, polymorphic: true
  belongs_to :profile

  scope :newest, -> { order('id DESC') }
  scope :order_by_publish_at, -> { order('publish_at DESC, id DESC') }

end
