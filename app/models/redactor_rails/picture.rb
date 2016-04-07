# == Schema Information
#
# Table name: redactor_assets
#
#  id                :integer          not null, primary key
#  data_file_name    :string           not null
#  data_content_type :string
#  data_file_size    :integer
#  assetable_id      :integer
#  assetable_type    :string(30)
#  type              :string(30)
#  width             :integer
#  height            :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class RedactorRails::Picture < RedactorRails::Asset
  mount_uploader :data, RedactorRailsPictureUploader, :mount_on => :data_file_name

  def url_content
    url(:content)
  end
end
