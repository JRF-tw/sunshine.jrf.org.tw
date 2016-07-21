class Party::VerdictScoreCheckInfoContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number].freeze
  SCORE_INTERVEL = 90.days

  before_perform :check_court_id
  before_perform :check_year
  before_perform :check_word_type
  before_perform :check_number
  before_perform :find_story
  before_perform :story_not_adjudge
  before_perform :valid_score_intervel

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @story
    end
  end

  private

  def check_court_id
    @court = Court.find(@params[:court_id]) if @params[:court_id].present?
    return add_error(:data_not_found, "選擇法院不存在") unless @court
  end

  def check_year
    return add_error(:data_blank, "年份不能為空") unless @params[:year].present?
  end

  def check_word_type
    return add_error(:data_blank, "字號不能為空") unless @params[:word_type].present?
  end

  def check_number
    return add_error(:data_blank, "案號不能為空") unless @params[:number].present?
  end

  def find_story
    return add_error(:data_not_found, "案件不存在") unless @story = Story.where(@params).last
  end

  def story_not_adjudge
    return add_error(:verdict_score_valid_failed, "尚未抓到判決書") unless @story.is_adjudge?
  end

  def valid_score_intervel
    range = (@story.adjudge_date..@story.adjudge_date + SCORE_INTERVEL)
    return add_error(:out_score_intervel, "已超過可評鑑時間") unless range.include?(Time.zone.today)
  end
end
