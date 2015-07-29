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
#

class Admin::Career < Career

end
