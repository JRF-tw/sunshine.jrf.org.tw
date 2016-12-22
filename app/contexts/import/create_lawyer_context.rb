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
      divide_phone_group
      office_numbers_assign if @office_numbers.present?
      phone_numbers_assign if @phone_numbers.present?
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
    @lawyer_data[:phone].size >= 20
  end

  def divide_phone_group
    @phone_numbers = []
    @office_numbers = []
    @lawyer_data[:phone].scan(/(0?(9)(\d{2})(-?([0-9]{3})){2})/) { |number| @phone_numbers << number[0] }
    @lawyer_data[:phone].scan(/((0\d{1,2}|\+(\d){1,4}|\(0\d{1,2}\))(-?[0-9]{3,4}){2}(#\d{1,7}){0,1})/) { |number| @office_numbers << number[0] }
  end

  def office_numbers_assign
    @office_numbers.each { |number| number.gsub!(/\(|\)|-|\s/, '') }
    assign_office_number(@office_numbers.join("\n"))
  end

  def phone_numbers_assign
    @phone_numbers.each { |number| number.gsub!(/\(|\)|-|\s/, '') }
    assign_phone_number(@phone_numbers.first)
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
