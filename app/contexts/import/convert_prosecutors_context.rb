class Import::ConvertProsecutorsContext < BaseContext

  def initialize
    @prosecutors_by_profile = Profile.where(current: '檢察官')
  end

  def perform
    run_callbacks :perform do
      prosecutors = []
      @prosecutors_by_profile.each do |p|
        prosecutors << Prosecutor.create(prosecutor_data(p))
      end
      prosecutors
    end
  end

  def prosecutor_data(p)
    {
      name: p.name,
      avatar: p.avatar,
      gender: p.gender,
      gender_source: p.gender_source,
      birth_year: p.birth_year,
      birth_year_source: p.birth_year_source,
      stage: p.stage,
      stage_source: p.stage_source,
      appointment: p.appointment,
      appointment_source: p.appointment_source,
      memo: p.memo,
      is_active: p.is_active,
      is_hidden: p.is_hidden
    }
  end
end
