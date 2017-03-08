class Scrap::UploadRefereeContext < BaseContext
  include Scrap::Concerns::AnalysisRefereeContent
  before_perform  :build_content_json
  before_perform  :build_crawl_data
  before_perform  :build_file
  before_perform  :assign_value
  after_perform   :remove_tempfile

  def initialize(orginal_data)
    @orginal_data = orginal_data
    @data = Nokogiri::HTML(@orginal_data)
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform(referee)
    @referee = referee
    @type = referee.class.name.downcase
    run_callbacks :perform do
      add_error('upload file failed') unless @referee.save
      true
    end
  rescue
    Logs::AddCrawlerError.send("add_#{@type}_error", @crawler_history, @referee, :upload_file_error, '檔案上傳s3失敗')
  end

  private

  def build_content_json
    @content_file_data = {}
    start_point = @data.css('pre').text.index('上列')
    @content_file_data['story_related_roles'] = parse_roles_hash(@referee, @data.text, @crawler_history)
    @content_file_data['main_content'] = @data.css('pre').text[start_point..-1]
  end

  def build_crawl_data
    @judge_word = @data.css('table')[2].css('table')[1].css('span')[0].text[/\d+,\p{Han}+,\d+/].tr(',', '-')
    @summary = @data.css('table')[2].css('table')[1].css('span')[2].text[/(?<=\u00a0)\p{Han}+/]
    @date = @data.css('table')[2].css('table')[1].css('span')[1].text[/\d+/]
    @related_story = prase_related_story(@data.text)
  end

  def build_file
    @file = generate_tempfile(@orginal_data, 'referee', 'html')
    @content_file = generate_tempfile(@content_file_data, @referee.story.identity, 'json')
  end

  def generate_tempfile(data, file_name, file_type)
    file = Tempfile.new([file_name, ".#{file_type}"], "#{Rails.root}/tmp/")
    file.write(data)
    file.rewind
    file.close
    file
  end

  def assign_value
    @referee.assign_attributes(
      file: File.open(@file.path),
      content_file: File.open(@content_file.path),
      roles_data: @content_file_data['story_related_roles'],
      date: @date,
      summary: @summary,
      judge_word: @judge_word,
      related_story: @related_story
    )
  end

  def remove_tempfile
    @file.unlink
    @content_file.unlink
  end
end
