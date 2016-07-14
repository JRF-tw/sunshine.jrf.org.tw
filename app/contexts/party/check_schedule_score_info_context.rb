class Party::CheckScheduleScoreInfoContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number].freeze

  before_perform :check_court_id
  before_perform :check_year
  before_perform :check_word_type
  before_perform :check_number
  before_perform :find_story
  before_perform :can_score, if: :story_has_pronounce_date?
  before_perform :story_already_adjudge

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
    return add_error(:date_blank, "年份不能為空") unless @params[:year].present?
  end

  def check_word_type
    return add_error(:date_blank, "字號不能為空") unless @params[:word_type].present?
  end

  def check_number
    return add_error(:date_blank, "案號不能為空") unless @params[:number].present?
  end

  def find_story
    return add_error(:data_not_found, "案件不存在") unless @story = Story.where(@params).last
  end

  def story_has_pronounce_date?
    @story.pronounce_date.present?
  end

  def can_score
    return add_error(:out_score_intervel, "案件已宣判, 無法評鑑") if Time.zone.today > @story.pronounce_date
  end

  def story_already_adjudge
    return add_error(:out_score_intervel, "已有判決書, 不可評鑑開庭") if @story.is_adjudge
  end
end
