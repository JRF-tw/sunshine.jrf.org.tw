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
    p.attributes.symbolize_keys.except(:id, :current, :created_at, :updated_at, :current_court, :punishments_count, :current_department, :current_branch)
  end
end
