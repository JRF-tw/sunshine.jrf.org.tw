class Admin::JudgeProsecutorToggleContext < BaseContext
  before_perform :find_or_new_judge, if: :convert_to_judge?
  before_perform :find_or_new_prosecutor, if: :convert_to_prosecutor?
  before_perform :build_role_relation
  before_perform :build_office_relation
  before_perform :set_judge_status
  before_perform :set_prosecutor_status

  def initialize(role)
    @origin_role = role
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_update_fail, @judge.errors.full_messages) unless @judge.save
      return add_error(:data_update_fail, @prosecutor.errors.full_messages) unless @prosecutor.save
      true
    end
  end

  private

  def converted_role_data
    {
      name: @origin_role.name,
      avatar: @origin_role.avatar,
      gender: @origin_role.gender,
      gender_source: @origin_role.gender_source,
      birth_year: @origin_role.birth_year,
      birth_year_source: @origin_role.birth_year_source,
      stage: @origin_role.stage,
      stage_source: @origin_role.stage_source,
      appointment: @origin_role.appointment,
      appointment_source: @origin_role.appointment_source,
      memo: @origin_role.memo
    }
  end

  def find_or_new_judge
    @judge = Admin::Judge.new(converted_role_data) unless judge_exist?
  end

  def find_or_new_prosecutor
    @prosecutor = Admin::Prosecutor.new(converted_role_data) unless prosecutor_exist?
  end

  def judge_exist?
    @judge = @prosecutor.judge || Judge.find_by_name(@origin_role.name)
  end

  def prosecutor_exist?
    @prosecutor = @judge.prosecutor || Prosecutor.find_by_name(@origin_role.name)
  end

  def build_role_relation
    @judge.prosecutor = @prosecutor
  end

  def build_office_relation
    @judge.court = @prosecutor.prosecutors_office.try(:court)
    @prosecutor.prosecutors_office = @judge.court.try(:prosecutors_office)
  end

  def convert_to_prosecutor?
    @judge = @origin_role if @origin_role.class == (Admin::Judge || Judge)
  end

  def convert_to_judge?
    @prosecutor = @origin_role if @origin_role.class == (Admin::Prosecutor || Prosecutor)
  end

  def set_judge_status
    params = convert_to_prosecutor? ? { is_prosecutor: true, is_active: false, is_hidden: true } : { is_prosecutor: false, is_active: true, is_hidden: false }
    @judge.assign_attributes(params)
  end

  def set_prosecutor_status
    params = convert_to_prosecutor? ? { is_active: true, is_hidden: false } : { is_active: false, is_hidden: true }
    @prosecutor.assign_attributes(params)
  end
end
