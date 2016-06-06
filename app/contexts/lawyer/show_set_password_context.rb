class Lawyer::ShowSetPasswordContext < BaseContext

  before_perform :check_lawyer_exist
  before_perform :check_lawyer_not_active

  def initialize(lawyer = nil)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      true
    end
  end

  private
  
  def check_lawyer_exist
    add_error(:lawyer_not_found, "無此律師資料") if !@lawyer 
    return false if !@lawyer
  end

  def check_lawyer_not_active
    add_error(:lawyer_exist, "此帳號已經註冊 請直接登入") if @lawyer.try(:confirmed?)
    return false if @lawyer.try(:confirmed?)
  end

end
