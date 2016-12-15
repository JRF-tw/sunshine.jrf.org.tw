module AdminMenuHelper
  def admin_menus
    {
      # "Menu #1": {
      #   submenu: {
      #     "Submenu #1": { url: url_for(q: 123), match: /q=123/ },
      #     "Submenu #2": { url: url_for(q: 456), match: /q=456/ }
      #   },
      #   icon: "star"
      # },
      # "Menu #2" => { url: url_for(q: 789), icon: "pencil", match: /q=789/ },
      "用戶管理": {
        submenu: {
          "後台使用者管理": { url: admin_users_path, match: /\/admin\/users/ },
          "觀察員管理": { url: admin_observers_path, match: /\/admin\/observers/ },
          "當事人管理": { url: admin_parties_path, match: /\/admin\/parties/ },
          "律師管理": { url: admin_lawyers_path, match: /\/admin\/lawyers/ }
        }
      },
      "法官管理": { url: admin_judges_path, match: /\/admin\/judges/ },
      "檢察官管理": { url: admin_prosecutors_path, match: /\/admin\/prosecutors/ },
      "法院 / 檢察署管理": { url: admin_courts_path, match: /\/admin\/courts/ },
      "檢察署管理": { url: admin_prosecutors_offices_path, match: /\/admin\/prosecutors_offices/ },
      "庭期表管理": { url: admin_schedules_path, match: /\/admin\/schedules/ },
      "案件管理": { url: admin_stories_path, match: /\/admin\/stories/ },
      "判決書管理": { url: admin_verdicts_path, match: /\/admin\/verdicts/ },
      "重要判決管理": { url: admin_judgments_path, match: /\/admin\/judgments/ },
      "個人檔案管理": { url: admin_profiles_path, match: /\/admin\/profiles/ },
      "評鑑資料-案例管理": { url: admin_suits_path, match: /\/admin\/suits/ },
      "首頁橫幅管理": { url: admin_banners_path, match: /\/admin\/banners/ },
      "司法案例面面觀橫幅管理": { url: admin_suit_banners_path, match: /\/admin\/suit_banners/ },
      "公告訊息管理": { url: admin_bulletins_path, match: /\/admin\/bulletins/ },
      "爬蟲紀錄": { url: admin_crawler_histories_path, match: /\/admin\/crawler_histories/ }
    }
  end

  def render_admin_menu(menus = nil)
    menus ||= admin_menus
    content_tag(:ul) do
      html = []
      menus.each do |label, item|
        html << render_admin_menu_item(label, item)
      end
      safe_join(html, '')
    end
  end

  private

  def render_admin_menu_item(label, item)
    html = []
    html << link_to(item[:submenu] ? '#' : item[:url]) do
      tmp = []
      tmp << content_tag(:i, class: "icon icon-#{item[:icon]}") { '' } if item[:icon]
      tmp << label
      safe_join(tmp, '')
    end
    html << render_admin_menu(item[:submenu]) if item[:submenu]
    actived = item[:match] ? request.original_url =~ item[:match] : false
    content_tag(:li, class: "#{item[:submenu] ? 'submenu ' : ''}#{actived ? 'active open' : ''}") do
      safe_join(html, '')
    end
  end
end
