module ApplicationHelper

  def class_of_about
    if (params[:controller] == 'base') && (params[:action] == 'about')
      return 'active'
    else
      return nil
    end
  end

  def class_of_searchs
    if params[:controller] == 'searchs'
      return 'active'
    else
      return nil
    end
  end

  def year_in_bc(year_in_tw)
    year_in_tw + 1911
  end

  def summary_text(content, len)
    truncate(content, length: len + 3)
  end

  def simple_text(text)
    safe_join([sanitize(text, tags: []).gsub(/\n/, '<br>')], '')
  end

  def render_punishment_decision_unit(punishment)
    if ['監察院(新)', '監察院(舊)'].include? punishment.decision_unit
      '監察院'
    elsif punishment.decision_unit == '公務人員保障暨培訓委員會'
      '保訓會'
    else
      punishment.decision_unit
    end
  end

  def render_punishment_cell(punishment)
    hash = {}
    if punishment.decision_unit == '公懲會'
      hash = {
        "議決日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "移送機關": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "決議結果": punishment.decision_result.present? ? punishment.decision_result : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == '檢評會'
      hash = {
        "決議日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "請 求 人": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif ['監察院(新)', '監察院'].include?(punishment.decision_unit)
      hash = {
        "議決日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": '監察院',
        "決議案號": punishment.decision_no.present? ? punishment.decision_no : nil,
        "決議種類": punishment.punish_type.present? ? punishment.punish_type : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == '監察院(舊)'
      hash = {
        "公告日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": '監察院',
        "發文字號": punishment.decision_no.present? ? punishment.decision_no : nil,
        "決議種類": punishment.punish_type.present? ? punishment.punish_type : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == '職務法庭'
      hash = {
        "裁判日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "移送機關": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit.to_s == '法評會'
      hash = {
        "決議日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "請 求 人": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == '司法院'
      hash = {
        "公告日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "執行機關": punishment.claimant.present? ? punishment.claimant : nil,
        "會議名稱": punishment.decision_no.present? ? punishment.decision_no : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "種    類": punishment.punish_type.present? ? punishment.punish_type : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == '公務人員保障暨培訓委員會'
      hash = {
        "決定日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "決    議": punishment.decision_result.present? ? punishment.decision_result : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    end
    hash.delete_if { |_k, v| v.nil? }
    hash
  end

  def collection_for_courts
    Court.shown.sorted.map { |c| [c.full_name, c.id] }.unshift(['全部法院', ''])
  end

  def collection_for_prosecutors_offices
    ProsecutorsOffice.shown.map { |c| [c.full_name, c.id] }.unshift(['全部檢察署', ''])
  end

  def active_for_search_group_cell(param, active = nil)
    param = '全部' if param.blank?
    (param == active.to_s) || (active.nil? && param.blank?) ? 'active' : ''
  end

  def render_career_content(career)
    if career.new_unit.present? || career.new_title.present?
      "#{career.new_unit} #{career.new_title}"
    else
      '暫無詳細資訊'
    end
  end

  def render_punishment_reason(punishment)
    arr = []
    arr << render_punishment_decision_unit(punishment) if punishment.decision_unit.present?
    if punishment.punish.present?
      arr << summary_text(punishment.punish, 20)
    elsif punishment.decision_result.present?
      arr << summary_text(punishment.decision_result, 20)
    elsif punishment.punish_type.present?
      arr << summary_text(punishment.punish_type, 20)
    end
    arr.join(' ')
  end

  def collect_for_schedule_branch_names
    Schedule.all.map(&:branch_name).uniq
  end

  def collect_for_courts
    Court.sorted.map { |c| [c.full_name, c.id] }
  end

  def collect_for_shown_courts
    Court.shown.sorted.map { |c| [c.full_name, c.id] }
  end

  def collect_for_prosecutors_offices
    ProsecutorsOffice.all.map { |c| [c.full_name, c.id] }
  end

  def collect_for_judges_name
    Judge.all.includes(:current_branches).map do |j|
      ["#{j.name} - #{j.current_branches.map(&:name).join(', ')}", j.id]
    end
  end

  def collect_for_lawyer_currents
    Lawyer.all.map(&:current).uniq
  end

  def collect_gender_by_user
    User::GENDER_TYPES
  end

  def collect_for_judgment_type
    [['是', true], ['否 (為裁決)', false]]
  end

  def collect_for_boolean
    [['是', true], ['否', false]]
  end

  def collect_for_is_null
    [['是', true], ['否', false]]
  end

  def collect_for_is_prosecutor
    [['法官', false], ['檢察官', true]]
  end

  def collect_for_is_judge
    [['檢察官', false], ['法官', true]]
  end

  def collect_for_register
    [['已註冊', true], ['未註冊', false]]
  end

  def collect_for_adjudgement
    [['是', 'yes'], ['否', 'no']]
  end

  def get_court_fullname(court_id)
    Court.find(court_id).full_name
  end

  def collect_for_story_types
    StoryTypes.list
  end

  def collect_for_observer_school
    ['中國文化大學', '靜宜大學', '中原大學', '國立勤益科技大學', '國立中正大學', '國立臺北大學']
  end

  def get_name_by_role(role)
    role.model_name.human
  end

  def get_institution_by_role(role)
    case role.class.name
    when 'Judge'
      role.court.try(:full_name)
    when 'Prosecutor'
      role.prosecutors_office.try(:full_name)
    end
  end

  def get_pluralize_by_role(role)
    role.class.to_s.downcase.demodulize.pluralize
  end

  def get_singularize_by_role(role)
    role.class.to_s.downcase.demodulize.singularize
  end

  def render_html(text)
    text = simple_format(text, {}, wrapper_tag: 'div')
    safe_join([text], '')
  end

  def already_subscribed_story?(role, story)
    role.story_subscriptions.find_by(story_id: story.id).present?
  end

  def topic_is_true_or_false?(topic_key)
    ScoreTopic.topic_type(topic_key) == 'true_or_false'
  end

  def true_or_false_keys(scored_type, main_topic_key)
    ScoreTopic.list_true_or_false_keys(scored_type, main_topic_key)
  end

  def show_true_or_false_main_topic(scored_type, main_topic_key)
    ScoreTopic.list_true_or_false_title(scored_type, main_topic_key)
  end

  def show_true_or_false_topic(scored_type, main_topic_key, topic_key)
    ScoreTopic.list_true_or_false_topic(scored_type, main_topic_key, topic_key)
  end

  def show_topic(scored_type, question_key)
    ScoreTopic.list_topic(scored_type, question_key)
  end

  def get_schedule_score_hstore_attributes(scores_type)
    ScheduleScore.stored_attributes[scores_type]
  end

  def smart_add_https(url)
    if url[/\Ahttp:\/\//]
      url.gsub(/\Ahttp/, 'https')
    elsif url[/\Ahttps:\/\//]
      url
    elsif url[/\A\/\//]
      "https:#{url}"
    else
      "https://#{url}"
    end
  end

  def url_for_search_story(court: nil, lawyer_name: nil, judge_name: nil, story_type: nil, reason: nil, adjudged_on: nil)
    search_stories_path(q: { court_id_in: [court.try(:id)], judges_names_cont: judge_name, lawyer_names_cont: lawyer_name, story_type_eq: story_type, reason_cont: reason, adjudged_on_gteq: adjudged_on, adjudged_on_lteq: adjudged_on })
  end

  def story_schedules_count_result(story)
    return '暫無' if story.schedules_count == 0
    story.schedules_count
  end
end
