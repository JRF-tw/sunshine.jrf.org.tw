# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  is_hidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BulletinsController < BaseController

  def index
  end

  def show
  end
end
