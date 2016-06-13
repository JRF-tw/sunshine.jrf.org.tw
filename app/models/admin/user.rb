# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
<<<<<<< e8ce4a4bbcc1a1a91accb58550162ed919778f15:app/models/admin/user.rb
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
=======
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  phone_number           :string
#  school                 :string
#  student_number         :string
#  department_level       :string
>>>>>>> 新增 律師 旁觀者 個人資料欄位:app/controllers/bystanders_controller.rb
#

class Admin::User < ::User
  
end
