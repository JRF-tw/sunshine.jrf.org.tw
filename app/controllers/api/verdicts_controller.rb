class Api::VerdictsController < Api::BaseController

  def show
    court_code, year, word, number = params[:id].split('-')
    @court = Court.find_by(code: court_code)
    return render json: { errors: '該法院不存在' } unless @court
    story = Story.find_by(year: year, word_type: word, number: number, court: @court)
    return render json: { errors: '此案件不存在' } unless story
    @verdicts = story.verdicts
    return render json: { messages: '此案件尚未有判決書' } unless @verdicts.present?
  end

end
