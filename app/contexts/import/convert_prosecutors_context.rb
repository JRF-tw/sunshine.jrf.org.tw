class Import::ConvertProsecutorsContext < BaseContext
  attr_reader :error_message

  def initialize
    @prosecutors_by_profile = Profile.where(current: '檢察官')
    @error_message = []
  end

  def perform
    run_callbacks :perform do
      prosecutors = []
      @prosecutors_by_profile.each do |prosecutor|
        p = Prosecutor.new(prosecutor_data(prosecutor))
        p.save ? prosecutors << p : @error_message << p.errors.full_messages
      end
      prosecutors
    end
  end

  def prosecutor_data(prosecutor)
    prosecutor.attributes.symbolize_keys.except(:id, :current, :created_at, :updated_at, :current_court, :punishments_count, :current_department, :current_branch)
  end
end
