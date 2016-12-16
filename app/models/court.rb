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

class Court < ActiveRecord::Base
  include HiddenOrNot
  sortable column: :weight, add_new_at: nil
  has_many :judgments
  has_many :stories
  has_many :schedules
  has_many :branches
  has_many :judges, foreign_key: :current_court_id
  has_one :prosecutors_office

  scope :newest, -> { order('id DESC') }
  scope :order_by_weight, -> { order('weight DESC, id DESC') }
  scope :with_codes, -> { where.not(code: nil) }

  class << self
    def collect_codes
      all.map(&:code)
    end
  end
end
