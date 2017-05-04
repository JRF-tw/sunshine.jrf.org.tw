class Scrap::UploadRefereeFileContext < BaseContext
  include Scrap::AnalysisRefereeContentConcern
  before_perform  :build_file
  before_perform  :assign_value
  after_perform   :remove_tempfile

  def initialize(orginal_data)
    @orginal_data = orginal_data
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform(referee)
    @referee = referee
    @type = referee.class.name.downcase
    run_callbacks :perform do
      unless @referee.save
        Logs::AddCrawlerError.send("add_#{@type}_error", @crawler_history, @referee, :upload_file_error, "檔案儲存失敗 #{@referee.errors.full_messages.join}")
      end
      true
    end
  end

  private

  def build_file
    @file = generate_tempfile(@orginal_data, 'referee', 'html')
  end

  def generate_tempfile(data, file_name, file_type)
    file = Tempfile.new([file_name, ".#{file_type}"], "#{Rails.root}/tmp/")
    file.write(data)
    file.rewind
    file.close
    file
  end

  def assign_value
    @referee.assign_attributes(file: File.open(@file.path))
  end

  def remove_tempfile
    @file.unlink
  end
end
