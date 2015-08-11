class Admin::Punishment < ::Punishment
  belongs_to :profile, :class_name => "Admin::Profile"

  validates_presence_of :profile_id
end
