class MailerPresenters
  def remind_story_before_judge(story)
    schedule = story.schedules.last
    date = schedule.start_at
    "您於司法陽光網訂閱#{story.detail_info}，該案即將於#{date.year}年#{date.mon}月#{date.mday}日#{date.hour}點#{date.min}分於#{story.court.full_name}#{story.story_type}#{schedule.courtroom}開庭，請記得寫上您的行事曆喔！"
  end

  def remind_story_after_judge(story)
    schedule = story.schedules.last
    date = schedule.start_at
    wday = I18n.t('date.day_names')[schedule.start_at.wday][2]
    "您於司法陽光網訂閱#{story.detail_info}，本次開庭日期為#{date.mon}月#{date.mday}日(#{wday})。若您已經開庭完畢，司改會邀請到司法陽光網提供您的寶貴意見！"
  end

  def google_calendar_link(story)
    datetime = story.schedules.last.start_at.utc
    date = datetime.strftime('%Y%m%d')
    start_time = datetime.strftime('%H%M') + '00'
    end_time = (datetime + 10_800).strftime('%H%M') + '00'
    "https://www.google.com/calendar/render?action=TEMPLATE&trp=true&sf=true&output=xml&dates=#{date}T#{start_time}Z/#{date}T#{end_time}Z&text=#{story.detail_info}案件開庭"
  end
end
