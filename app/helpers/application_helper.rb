module ApplicationHelper

  def class_of_suits
    if (params[:controller] == "suits")
      return "active"
    else
      return nil
    end
  end

  def class_of_judges
    if (params[:controller] == "profiles") && (params[:action] == "judges")
      return "active"
    else
      return nil
    end
  end

  def class_of_prosecutors
    if (params[:controller] == "profiles") && (params[:action] == "prosecutors")
      return "active"
    else
      return nil
    end
  end

  def class_of_about
    if (params[:controller] == "base") && (params[:action] == "about")
      return "active"
    else
      return nil
    end
  end

  def class_of_searchs
    if (params[:controller] == "searchs")
      return "active"
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
    sanitize(text, tags: []).gsub(/\n/, '<br>').html_safe
  end

  def render_punishment_decision_unit(punishment)
    if ["監察院(新)", "監察院(舊)"].include? punishment.decision_unit
      "監察院"
    elsif punishment.decision_unit == "公務人員保障暨培訓委員會"
      "保訓會"
    else
      punishment.decision_unit
    end
  end

  def render_punishment_cell(punishment)
    hash = Hash.new
    if punishment.decision_unit == "公懲會"
      hash = {
        "議決日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "移送機關": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "決議結果": punishment.decision_result.present? ? punishment.decision_result : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == "檢評會"
      hash = {
        "決議日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "請 求 人": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif ["監察院(新)", "監察院"].include?(punishment.decision_unit)
      hash = {
        "議決日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": "監察院",
        "決議案號": punishment.decision_no.present? ? punishment.decision_no : nil,
        "決議種類": punishment.punish_type.present? ? punishment.punish_type : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == "監察院(舊)"
      hash = {
        "公告日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": "監察院",
        "發文字號": punishment.decision_no.present? ? punishment.decision_no : nil,
        "決議種類": punishment.punish_type.present? ? punishment.punish_type : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == "職務法庭"
      hash = {
        "裁判日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "移送機關": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit.to_s == "法評會"
      hash = {
        "決議日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "請 求 人": punishment.claimant.present? ? punishment.claimant : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == "司法院"
      hash = {
        "公告日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "執行機關": punishment.claimant.present? ? punishment.claimant : nil,
        "會議名稱": punishment.decision_no.present? ? punishment.decision_no : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "種    類": punishment.punish_type.present? ? punishment.punish_type : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    elsif punishment.decision_unit == "公務人員保障暨培訓委員會"
      hash = {
        "決定日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "字    號": punishment.punish_no.present? ? punishment.punish_no : nil,
        "決    議": punishment.decision_result.present? ? punishment.decision_result : nil,
        "結    果": punishment.punish.present? ? punishment.punish : nil
      }
    end
    hash.delete_if { |k, v| v == nil }
    hash
  end

  def collection_for_courts
    Court.get_courts.order_by_weight.map{ |c| c.full_name }.unshift("全部法院")
  end

  def collection_for_prosecutors
    Court.prosecutors.order_by_weight.map{ |c| c.full_name }.unshift("全部檢察署")
  end

  def collection_state_for_suits
    Suit::STATE.clone.unshift("全部")
  end

  def active_for_search_group_cell(param, active = nil)
    param = "全部" if param.blank?
    (param == active.to_s) || (active.nil? && param.blank?) ?  "active" : ""
  end

  def render_career_content(career)
    if career.new_unit.present? || career.new_title.present?
      "#{career.new_unit} #{career.new_title}"
    else
      "暫無詳細資訊"
    end
  end

  def render_punishment_reason(punishment)
    arr = []
    arr << render_punishment_decision_unit(punishment) if punishment.decision_unit.present?
    if punishment.punish.present?
      arr << summary_text(punishment.punish , 20)
    elsif punishment.decision_result.present?
      arr << summary_text(punishment.decision_result , 20)
    elsif punishment.punish_type.present?
      arr << summary_text(punishment.punish_type , 20)
    end
    return arr.join(" ")
  end

  def collect_for_story_types
    Story.all.map(&:story_type).uniq.compact
  end

  def collect_for_schedule_branch_names
    Schedule.all.map(&:branch_name).uniq
  end

  def collect_for_court_types
    Court.all.map(&:court_type).uniq.compact
  end

  def collect_for_courts
    Court.get_courts.map{ |c| [c.full_name, c.id] }
  end

  def collect_for_judges_name
    Judge.all.includes(:branches).map do |j|
      ["#{j.name} - #{j.branches.map(&:name).join(", ")}", j.id]
    end
  end

  def collect_for_lawyer_currents
    Lawyer.all.map(&:current).uniq
  end

  def collect_gender_by_user
    User::GENDER_TYPES
  end

  def collect_for_judge_active
    User::ACTIVE_TYPES
  end

  def collect_for_is_adjudge
    [["已宣判", true], ["尚未宣判", false]]
  end

  def collect_for_is_hidden
    [["不顯示於前端", true],["顯示於前端", false]]
  end

  def collect_for_verdicts_is_judgment
    [["有", true]]
  end

  def collect_for_boolean
    [["是", true], ["否", false]]
  end

end

