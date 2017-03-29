# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  adjudge_date     :date
#  published_on     :date
#  content_file     :string
#  crawl_data       :hstore
#  roles_data       :hstore
#  reason           :string
#  related_stories  :text
#

class Admin::Verdict < ::Verdict
end
