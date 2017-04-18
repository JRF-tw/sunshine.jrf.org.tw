# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  court_id         :integer
#  story_type       :string
#  year             :integer
#  word_type        :string
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_adjudged      :boolean          default(FALSE)
#  adjudged_on      :date
#  pronounced_on    :date
#  is_pronounced    :boolean          default(FALSE)
#  is_calculated    :boolean          default(FALSE)
#  reason           :string
#

class Admin::Story < ::Story

end
