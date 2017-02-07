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

class Admin::Career < ::Career
  belongs_to :profile, class_name: 'Admin::Profile'

  validates :profile_id, :career_type, :publish_at_in_tw, presence: true

  after_save :update_profile_current_court

  private

  def update_profile_current_court
    newest_career = profile.careers.order_by_publish_at.first
    if (is_hidden == false) && (newest_career == self)
      if new_assign_court.present?
        profile.update_column :current_court, new_assign_court
        if ['法官', '檢察官'].include? new_assign_judicial
          profile.update_column :current, new_assign_judicial
        else
          profile.update_column :current, '其他'
        end
      elsif new_unit.present?
        profile.update_column :current_court, new_unit
        if ['法官', '檢察官'].include? new_title
          profile.update_column :current, new_title
        else
          profile.update_column :current, '其他'
        end
      end
    end
  end
end
