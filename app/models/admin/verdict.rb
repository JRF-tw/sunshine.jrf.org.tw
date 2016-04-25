# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_judgment      :boolean
#

class Admin::Verdict < ::Verdict

end
