class Scrap::UploadRefereeContentFileContext < BaseContext
  include Scrap::AnalysisRefereeContentConcern
  before_perform  :build_content_json
  before_perform  :build_crawl_data
  before_perform  :build_file
  before_perform  :assign_value
  after_perform   :remove_tempfile

  def initialize(orginal_data)
    @orginal_data = orginal_data
    @data = Nokogiri::HTML(@orginal_data)
    @content = @data.css('pre').text
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
    @content_file_data = {}
  end

  def perform(referee)
    @referee = referee
    @type = referee.class.name.downcase
    run_callbacks :perform do
      unless @referee.save
        Logs::AddCrawlerError.send("add_#{@type}_error", @crawler_history, @referee, :upload_file_error, "內文儲存失敗 #{@referee.errors.full_messages.join}")
      end
      true
    end
  rescue
    Logs::AddCrawlerError.send("add_#{@type}_error", @crawler_history, @referee, :upload_file_error, '內文資料解析失敗')
  end

  private

  def build_content_json
    start_point = get_content_start_point(@content)
    @content_file_data['related_roles'] = parse_roles_hash(@referee, @content, @crawler_history)
    @content_file_data['main_content'] = @data.css('pre').text[start_point..-1]
  end

  def build_crawl_data
    @judge_word = @data.css('table')[2].css('table')[1].css('span')[0].text[/\d+,\p{Han}+,\d+/].tr(',', '-')
    @reason = @data.css('table')[2].css('table')[1].css('span')[2].text[/(?<=\u00a0)\p{Han}+/]
    @related_stories = prase_related_stories(@data.text)
  end

  def build_file
    @content_file = generate_tempfile(@content_file_data.to_json, @referee.story.identity, 'json')
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
      content_file: File.open(@content_file.path),
      reason: @reason,
      roles_data: @content_file_data['related_roles'],
      judge_word: @judge_word,
      related_stories: @related_stories
    )
  end

  def remove_tempfile
    @content_file.unlink
  end
end
