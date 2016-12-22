class Import::CreateLawyerContext < BaseContext
  before_perform  :check_has_email
  before_perform  :check_email_not_exist
  before_perform  :check_has_name
  before_perform  :assign_phone, if: :phone_exist?
  before_perform  :clean_phone_params
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

  def check_has_email
    return add_error(:lawyer_email_blank) unless @lawyer_data[:email].present?
  end

  def check_email_not_exist
    return add_error(:lawyer_exist) if Lawyer.pluck(:email).include?(@lawyer_data[:email].downcase)
  end

  def check_has_name
    return add_error(:lawyer_name_blank) unless @lawyer_data[:name].present?
  end

  def assign_phone
    phone_reformat
    if multi_phone_include?
      multi_phone_divide
      multi_phones_assign
    else
      single_phone_assign
    end
  end

  def phone_exist?
    @lawyer_data[:phone].present?
  end

  def phone_reformat
    @lawyer_data[:phone] = @lawyer_data[:phone].to_s
    @lawyer_data[:phone] = '0' + @lawyer_data[:phone] unless @lawyer_data[:phone][/\A0|\(|\+/]
    @lawyer_data[:phone].gsub!(/(\s*分機)/, '#')
  end

  def multi_phone_include?
    @lawyer_data[:phone][/(\(0\d+\))/] && (@lawyer_data[:phone][/(\s09)/] || @lawyer_data[:phone][/\A09/])
  end

  def multi_phone_divide
    @phone_number = @lawyer_data[:phone][/(09)(\d{2})((-{0,1})([0-9]{3})){2}/].gsub(/\(|\)|-|\s/, '')
    @phone_number.gsub!(/\(|\)|-|\s/, '') if @phone_number
    @office_number = @lawyer_data[:phone][/(\(0\d{1,2}\))(\d{3,4})-(\d{3,4})(#\d{1,5}){0,1}/].gsub(/\(|\)|-|\s/, '')
    @office_number.gsub!(/\(|\)|-|\s/, '') if @office_number
  end

  def multi_phones_assign
    assign_phone_number(@phone_number) if @phone_number
    assign_office_number(@office_number) if @office_number
  end

  def single_phone_assign
    @lawyer_data[:phone].gsub!(/\(|\)|-|\s/, '')
    @lawyer_data[:phone][0, 2] == '09' ? assign_phone_number : assign_office_number
  end

  def assign_phone_number(phone_number = nil)
    @lawyer_data[:phone_number] = phone_number || @lawyer_data[:phone]
  end

  def assign_office_number(office_number = nil)
    @lawyer_data[:office_number] = office_number || @lawyer_data[:phone]
  end

  def clean_phone_params
    @lawyer_data.delete(:phone)
  end

  def build_lawyer
    @lawyer = Lawyer.new(@lawyer_data)
  end

end
