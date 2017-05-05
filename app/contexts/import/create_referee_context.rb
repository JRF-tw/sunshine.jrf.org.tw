class Import::CreateRefereeContext < BaseContext
  include Scrap::AnalysisRefereeContentConcern

  before_perform :parse_json_data
  before_perform :find_court
  before_perform :find_or_create_story
  before_perform :find_or_create_referee
  before_perform :create_main_judge_by_highest, if: :is_highest_court?
  before_perform :assign_names
  before_perform :build_content_json
  before_perform :build_file
  before_perform :assign_attributes
  after_perform  :update_data_to_story
  after_perform  :update_date_to_story, if: :is_verdict?
  after_perform  :create_relation_for_role, if: :is_verdict?
  after_perform  :remove_tempfile

  def initialize(hash_data)
    @data = hash_data
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
    @content_file_data = {}
  end

  def perform
    run_callbacks :perform do
      return false unless @referee.save
      @referee
    end
  end

  private

  def parse_json_data
    @court_code = @data['JID'].split(',').first[0..2]
    @story_type = convert_type(@data['JID'].split(',').first[3])
    @year = @data['JYEAR']
    @word = @data['JCASE']
    @number = @data['JNO']
    @adjudged_on = @data['JDATE'].to_date
    @reason = @data['JTITLE']
    @content = @data['JFULL']
  end

  def find_court
    return false unless @court = Court.find_by(code: @court_code)
  end

  def find_or_create_story
    @story = Story.find_or_create_by(story_type: @story_type, year: @year, word_type: @word, number: @number, court: @court)
  end

  def find_or_create_referee
    referee_class = is_verdict? ? Verdict : Rule
    @referee = referee_class.find_or_create_by(
      story: @story,
      adjudged_on: @adjudged_on
    )
  end

  def create_main_judge_by_highest
    parse_judges_names(@referee, @content, @crawler_history).each do |judge|
      Scrap::CreateJudgeByHighestCourtContext.new(@court, judge).perform
    end
  end

  def is_highest_court?
    @court.code == 'TPS'
  end

  def build_content_json
    start_point = get_content_start_point(@content)
    @content_file_data['related_roles'] = parse_roles_hash(@referee, @content, @crawler_history)
    @content_file_data['main_content'] = @content[start_point..-1]
  end

  def build_file
    @content_file = generate_tempfile(@content_file_data.to_json, @referee.story.identity, 'json')
  end

  def assign_attributes
    @referee.assign_attributes(
      content_file: File.open(@content_file.path),
      reason: @reason,
      roles_data: @content_file_data['related_roles']
    )
  end

  def assign_names
    @referee.assign_attributes(
      judges_names: parse_judges_names(@referee, @content, @crawler_history),
      prosecutor_names: parse_prosecutor_names(@referee, @content, @crawler_history),
      lawyer_names: parse_lawyer_names(@referee, @content, @crawler_history),
      party_names: parse_party_names(@referee, @content, @crawler_history)
    )
  end

  def update_data_to_story
    @story.assign_attributes(reason: @referee.reason) if @referee.reason
    @story.assign_attributes(judges_names: (@story.judges_names + @referee.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @referee.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @referee.lawyer_names).uniq)
    @story.assign_attributes(party_names: (@story.party_names + @referee.party_names).uniq)
    @story.save
  end

  def update_date_to_story
    @story.update_attributes(adjudged_on: @adjudged_on, is_adjudged: true) unless @story.adjudged_on
    @story.update_attributes(pronounced_on: Time.zone.today, is_pronounced: true) unless @story.pronounced_on
  end

  def create_relation_for_role
    verdict_role_name = @referee.lawyer_names + @referee.judges_names + @referee.party_names + @referee.prosecutor_names
    verdict_role_name.each do |name|
      VerdictRelationCreateContext.new(@referee).perform(name)
      Story::RelationCreateContext.new(@story).perform(name)
    end
  end

  def remove_tempfile
    @content_file.unlink
  end

  def convert_type(type)
    case type
    when 'A'
      '行政'
    when 'M'
      '刑事'
    when 'V'
      '民事'
    when 'P'
      '公懲'
    end
  end

  def is_verdict?
    @content.split.first.match(/判決/).present?
  end

  def generate_tempfile(data, file_name, file_type)
    file = Tempfile.new([file_name, ".#{file_type}"], "#{Rails.root}/tmp/")
    file.write(data)
    file.rewind
    file.close
    file
  end
end
