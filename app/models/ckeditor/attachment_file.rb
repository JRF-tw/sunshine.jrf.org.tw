# == Schema Information
#
# Table name: ckeditor_assets
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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Ckeditor::AttachmentFile < Ckeditor::Asset
  mount_uploader :data, CkeditorAttachmentFileUploader, mount_on: :data_file_name

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
