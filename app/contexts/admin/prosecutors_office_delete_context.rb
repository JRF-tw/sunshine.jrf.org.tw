class Admin::ProsecutorsOfficeDeleteContext < BaseContext

  def initialize(prosecutors_office)
    @prosecutors_office = prosecutors_office
  end

  def perform
    run_callbacks :perform do
      @prosecutors_office.destroy
    end
  end

end
