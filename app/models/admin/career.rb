# == Schema Information
#
# Table name: careers
#
#  id                  :integer          not null, primary key
#  profile_id          :integer
#  career_type         :string(255)
#  old_unit            :string(255)
#  old_title           :string(255)
#  old_assign_court    :string(255)
#  old_assign_judicial :string(255)
#  old_pt              :string(255)
#  new_unit            :string(255)
#  new_title           :string(255)
#  new_assign_court    :string(255)
#  new_assign_judicial :string(255)
#  new_pt              :string(255)
#  start_at            :date
#  end_at              :date
#  publish_at          :date
#  source              :text
#  source_link         :string(255)
#  origin_desc         :text
#  memo                :text
#  created_at          :datetime
#  updated_at          :datetime
#  is_hidden           :boolean
#

class Admin::Career < ::Career
  belongs_to :profile, class_name: "Admin::Profile"
  
  validates_presence_of :profile_id, :career_type, :publish_at_in_tw

  after_save :update_profile_current_court

  private

  def update_profile_current_court
    newest_career = profile.careers.order_by_publish_at.first
    if (is_hidden == false) && new_unit.present? && (newest_career == self)
      if new_assign_court.present?
        profile.update_column :current_court, new_assign_court
      else
        profile.update_column :current_court, new_unit
      end
    end
  end 
end
