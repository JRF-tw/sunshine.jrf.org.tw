# == Schema Information
#
# Table name: judges
#
#  id                 :integer          not null, primary key
#  name               :string
#  current_court_id   :integer
#  avatar             :string
#  gender             :string
#  gender_source      :string
#  birth_year         :integer
#  birth_year_source  :string
#  stage              :integer
#  stage_source       :string
#  appointment        :string
#  appointment_source :string
#  memo               :string
#  is_active          :boolean          default(TRUE)
#  is_hidden          :boolean          default(TRUE)
#  punishments_count  :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_prosecutor      :boolean          default(FALSE)
#

class Admin::Judge < ::Judge
  has_many :branches
  belongs_to :court, class_name: 'Court', foreign_key: :current_court_id

  validates :name, presence: true
end
