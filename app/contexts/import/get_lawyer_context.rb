class Import::GetLawyerContext < BaseContext
  before_perform :build_tempfile
  before_perform :transfer_data_to_array
  after_perform  :remove_tempfile

  def initialize(data_url)
    @data = open(data_url).read
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

  def build_tempfile
    @file = Tempfile.new("lawyers", "#{Rails.root}/tmp/")
    @file.write(@data)
    @file.rewind
    @file.close
  end

  def transfer_data_to_array
    @data_array = SmarterCSV.process(@file.path)
  end

  def remove_tempfile
    @file.unlink
  end
end
