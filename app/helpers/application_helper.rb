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
    if content.length > len
      content.first(len) + "..."
    else
      content
    end
  end

  def render_punishment_cell(punishment)
    hash = Hash.new
    if punishment.decision_unit == "公懲會"
      hash = {
        "議決日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "移送機關": punishment.claimant.present? ? punishment.claimant : nil,
        "決議結果": punishment.decision_result.present? ? punishment.decision_result : nil
      }
    elsif punishment.decision_unit == "檢評會"
      hash = {
        "決議日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "請 求 人": punishment.claimant.present? ? punishment.claimant : nil
      }
    elsif punishment.decision_unit == ("監察院(新)" || "監察院")
      hash = {
        "議決日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": "監察院",
        "決議案號": punishment.decision_no.present? ? punishment.decision_no : nil,
        "決議種類": punishment.punish_type.present? ? punishment.punish_type : nil
      }
    elsif punishment.decision_unit == "監察院(舊)"
      hash = {
        "公告日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": "監察院",
        "發文字號": punishment.decision_no.present? ? punishment.decision_no : nil,
        "決議種類": punishment.punish_type.present? ? punishment.punish_type : nil
      }
    elsif punishment.decision_unit == "職務法庭"
      hash = {
        "裁判日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "移送機關": punishment.claimant.present? ? punishment.claimant : nil
      }
    elsif punishment.decision_unit.to_s == "法評會"
      hash = {
        "決議日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "請 求 人": punishment.claimant.present? ? punishment.claimant : nil
      }
    elsif punishment.decision_unit == "司法院"
      hash = {
        "公告日期": punishment.relevant_date.present? ? punishment.relevant_date : nil,
        "決定機關": punishment.decision_unit.present? ? punishment.decision_unit : nil,
        "懲處機關": punishment.claimant.present? ? punishment.claimant : nil,
        "會議名稱": punishment.decision_no.present? ? punishment.decision_no : nil,
        "懲處種類": punishment.punish_type.present? ? punishment.punish_type : nil
      }
    end
    hash.delete_if { |k, v| v == nil }
    hash
  end
end