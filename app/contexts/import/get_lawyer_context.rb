class Import::GetLawyerContext < BaseContext

  def initialize(data_array)
    @data_array = data_array
    @import_lawyers = []
  end

  def perform
    run_callbacks :perform do
      @data_array.each do |lawyer|
        @import_lawyers << @lawyer if @lawyer = Import::CreateLawyerContext.new(lawyer).perform
      end
      @import_lawyers
    end
  end
end
