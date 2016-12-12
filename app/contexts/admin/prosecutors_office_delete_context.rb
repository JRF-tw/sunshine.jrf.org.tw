class Admin::ProsecutorsOfficeDeleteContext < BaseContext
  before_perform :check_prosecutors

  def initialize(prosecutors_office)
    @prosecutors_office = prosecutors_office
  end

  def perform
    run_callbacks :perform do
      @prosecutors_office.destroy
    end
  end

  private

  def check_prosecutors
    return add_error(:data_delete_fail, '無法刪除 已存在檢察官"') if @prosecutors_office.prosecutors.present?
  end
end
