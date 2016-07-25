class Import::CreateLawyerContext < BaseContext
  before_perform  :check_email_not_exist
  before_perform  :check_has_name_and_email
  before_perform  :phone_format_check
  before_perform  :define_phone_type
  before_perform  :build_lawyer

  def initialize(lawyer_data)
    @lawyer_data = lawyer_data
  end

  def perform
    run_callbacks :perform do
      add_error(:data_create_fail, "律師建立失敗") unless @lawyer.save
      @lawyer
    end
  end

  private

  def check_email_not_exist
    add_error(:lawyer_exist, "該律師已存在") if Lawyer.pluck(:email).include?(@lawyer_data[:email])
  end

  def check_has_name_and_email
    add_error(:data_blank, "律師資料不足") unless @lawyer_data[:email].present? && @lawyer_data[:name].present?
  end

  def phone_format_check
    @lawyer_data[:phone] = @lawyer_data[:phone].to_s
    @lawyer_data[:phone] = "0" + @lawyer_data[:phone] if @lawyer_data[:phone].present? && @lawyer_data[:phone][0] != "0"
  end

  def define_phone_type
    if @lawyer_data[:phone][0, 2] == "09"
      @lawyer_data[:phone_number] = @lawyer_data.delete(:phone)
    else
      @lawyer_data[:office_number] = @lawyer_data.delete(:phone)
    end
  end

  def build_lawyer
    @lawyer = Lawyer.new(@lawyer_data)
  end

end
