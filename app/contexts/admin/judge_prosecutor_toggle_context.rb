class Admin::JudgeProsecutorToggleContext < BaseContext
  before_perform :check_role
  before_perform :set_new_role
  before_perform :build_role_relation
  after_perform :set_old_role

  def initialize(role)
    @old_role = role
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_update_fail,  @new_role.errors.full_messages) unless @new_role.save
      true
    end
  end

  private

  def converted_role_data
    @old_role.attributes.symbolize_keys.except(:id, :created_at, :judge_id, :updated_at, :punishments_count, :current_court_id, :prosecutors_office_id, :is_prosecutor , :is_judge)
  end

  def check_role
    return add_error(:data_update_fail, 'invalid role') unless convert_to_prosecutor? || convert_to_judge?
  end

  def set_new_role
    if convert_to_prosecutor?
      find_or_new_prosecutor
      @new_role.assign_attributes(is_judge: false, is_active: true, is_hidden: false)
      @new_role.prosecutors_office = @old_role.court.try(:prosecutors_office) if @new_role.new_record?
    else
      find_or_new_judge
      @new_role.assign_attributes(is_prosecutor: false, is_active: true, is_hidden: false)
      @new_role.court = @old_role.prosecutors_office.try(:court) if @new_role.new_record?
    end
  end

  def find_or_new_judge
    @new_role = @old_role.judge || Judge.find_by_name(@old_role.name) || Admin::Judge.new(converted_role_data)
  end

  def find_or_new_prosecutor
    @new_role = @old_role.prosecutor || Prosecutor.find_by_name(@old_role.name) || Admin::Prosecutor.new(converted_role_data)
  end

  def build_role_relation
    convert_to_prosecutor? ? @new_role.judge = @old_role : @new_role.prosecutor = @old_role
  end

  def convert_to_prosecutor?
    @old_role.class.to_s.demodulize == 'Judge'
  end

  def convert_to_judge?
    @old_role.class.to_s.demodulize == 'Prosecutor'
  end

  def set_old_role
    convert_to_prosecutor? ? @old_role.update_attributes(is_prosecutor: true, is_active: false, is_hidden: true) : @old_role.update_attributes(is_judge: true, is_active: false, is_hidden: true)
  end
end
