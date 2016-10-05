class Import::GetLawyerContext < BaseContext
  before_perform :build_tempfile
  before_perform :transfer_data_to_array
  after_perform  :remove_tempfile

  attr_reader :error_message
  attr_reader :import_lawyers

  def initialize(data_url)
    @data = open(data_url).read
    @error_message = []
    @import_lawyers = []
  end

  def perform
    run_callbacks :perform do
      @data_array.each do |lawyer|
        context = Import::CreateLawyerContext.new(lawyer)
        if @lawyer = context.perform
          @import_lawyers << @lawyer
        else
          @error_message << context.errors
        end
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
