class VerdictFileToContentContext < BaseContext
  before_perform :check_file_exist
  before_perform :catch_content_data
  before_perform :bulid_tempfile
  before_perform :assign_value
  after_perform :remove_tempfile

  def initialize(verdict)
    @verdict = verdict
    @file_url = 'http:' + verdict.file.url
  end

  def perform
    run_callbacks :perform do
      add_error('upload content failed') unless @verdict.save
      true
    end
  end

  private

  def check_file_exist
    return add_error(:data_create_fail, '該判決沒有檔案') unless @file_url
  end

  def catch_content_data
    response_data = Mechanize.new.get(@file_url)
    response_data = Nokogiri::HTML(response_data.body)
    @content_data = response_data.css('pre')[0].text
  end

  def bulid_tempfile
    @file = Tempfile.new(['verdict', '.text'], "#{Rails.root}/tmp/")
    @file.write(@content_data)
    @file.rewind
    @file.close
  end

  def assign_value
    @verdict.assign_attributes(content: File.open(@file.path))
  end

  def remove_tempfile
    @file.unlink
  end
end
