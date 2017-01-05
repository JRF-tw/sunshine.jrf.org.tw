class Scrap::UploadVerdictContext < BaseContext
  before_perform  :bulid_tempfile
  before_perform  :assign_value
  after_perform   :remove_tempfile

  def initialize(content)
    @content = content
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform(verdict)
    @verdict = verdict
    run_callbacks :perform do
      add_error('upload file failed') unless @verdict.save
      true
    end
  rescue
    Logs::AddCrawlerError.add_verdict_error(@crawler_history, @verdict, :parse_judge_empty, '判決書上傳失敗')
  end

  private

  def bulid_tempfile
    @file = Tempfile.new(['verdict', '.html'], "#{Rails.root}/tmp/")
    @file.write(@content)
    @file.rewind
    @file.close
  end

  def assign_value
    @verdict.assign_attributes(file: File.open(@file.path))
  end

  def remove_tempfile
    @file.unlink
  end
end
