class Scrap::UploadVerdictContext < BaseContext
  before_perform  :build_content_json
  before_perform  :build_file
  before_perform  :assign_value
  after_perform   :remove_tempfile

  def initialize(orginal_data)
    @orginal_data = orginal_data
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

  def build_content_json
    @content_data = {}
    data = Nokogiri::HTML(@orginal_data)
    @content_data['word'] = data.css('table')[2].css('table')[1].css('span')[0].text[/\d+,[\u4e00-\u9fa5]+,\d+/]
    @content_data['date'] = data.css('table')[2].css('table')[1].css('span')[1].text[/\d+/]
    @content_data['summary'] = data.css('table')[2].css('table')[1].css('span')[2].text.split(/\u00a0/).last
    @content_data['content'] = data.css('table')[2].css('table')[1].css('pre')[0].text
    @content_data = @content_data.to_json
  end

  def build_file
    @file = generate_tempfile(@orginal_data, 'verdict', 'html')
    @content_file = generate_tempfile(@content_data, @verdict.story.identity, 'json')
  end

  def generate_tempfile(data, file_name, file_type)
    file = Tempfile.new([file_name, ".#{file_type}"], "#{Rails.root}/tmp/")
    file.write(data)
    file.rewind
    file.close
    file
  end

  def assign_value
    @verdict.assign_attributes(file: File.open(@file.path), content_file: File.open(@content_file.path))
  end

  def remove_tempfile
    @file.unlink
    @content_file.unlink
  end
end
