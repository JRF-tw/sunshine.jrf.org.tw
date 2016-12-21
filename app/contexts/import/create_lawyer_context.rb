class Import::CreateLawyerContext < BaseContext
  before_perform  :check_email_not_exist
  before_perform  :check_has_name
  before_perform  :check_has_email
  before_perform  :phone_format_check
  before_perform  :assign_phone_number, if: :is_phone?
  before_perform  :assign_office_number, unless: :is_phone?
  before_perform  :build_lawyer

  def initialize(lawyer_data)
    @lawyer_data = lawyer_data
  end

  def perform
    run_callbacks :perform do
      return add_error(:lawyer_create_fail) unless @lawyer.save
      @lawyer
    end
  end

  private

  def check_email_not_exist
    return add_error(:lawyer_exist) if Lawyer.pluck(:email).include?(@lawyer_data[:email])
  end

  def check_has_name
    return add_error(:lawyer_name_blank) unless @lawyer_data[:name].present?
  end

  def check_has_email
    return add_error(:lawyer_email_blank) unless @lawyer_data[:email].present?
  end

  def phone_format_check
    phone_format_adjust
    @lawyer_data[:phone] = '0' + @lawyer_data[:phone] if @lawyer_data[:phone].present? && @lawyer_data[:phone][0] != '0'
  end

  def phone_format_adjust
    @lawyer_data[:phone] = @lawyer_data[:phone].to_s
    @lawyer_data[:phone].gsub!(/[\s()-]/, '')
    @lawyer_data[:phone].gsub!(/[(分機)]/, '#')
  end

  def is_phone?
    @lawyer_data[:phone] && @lawyer_data[:phone][0, 2] == '09'
  end

  def assign_phone_number
    @lawyer_data[:phone_number] = @lawyer_data.delete(:phone)
  end

  def assign_office_number
    @lawyer_data[:office_number] = @lawyer_data.delete(:phone)
  end

  def build_lawyer
    @lawyer = Lawyer.new(@lawyer_data)
  end

end
