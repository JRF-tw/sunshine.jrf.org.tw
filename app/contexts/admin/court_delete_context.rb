class Admin::CourtDeleteContext < BaseContext
  before_perform :check_judges

  def initialize(court)
    @court = court
  end

  def perform
    run_callbacks :perform do
      @court.destroy
    end
  end

  def check_judges
    return add_error(:data_delete_fail, '無法刪除 已存在法官"') if @court.judges.present?
  end

end
