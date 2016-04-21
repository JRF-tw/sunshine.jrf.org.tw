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
      "個人檔案管理": { url: admin_profiles_path, match: /\/admin\/profiles/ },
      "法官管理": { url: admin_judges_path, match: /\/admin\/judges/ },
      "重要判決管理": { url: admin_judgments_path, match: /\/admin\/judgments/ },
      "評鑑資料-案例管理": { url: admin_suits_path, match: /\/admin\/suits/ },
      "案件管理": { url: admin_stories_path, match: /\/admin\/stories/ },
      "法院 / 檢察署管理": { url: admin_courts_path, match: /\/admin\/courts/ },
      "庭期表管理": { url: admin_schedules_path, match: /\/admin\/schedules/ },
      "首頁橫幅管理": { url: admin_banners_path, match: /\/admin\/banners/ },
      "司法案例面面觀橫幅管理": { url: admin_suit_banners_path, match: /\/admin\/suit_banners/ },
      "後台使用者管理": { url: admin_users_path, match: /\/admin\/users/ }
    }
  end

  def render_admin_menu(menus = nil)
    menus ||= admin_menus
    content_tag(:ul) do
      html = []
      menus.each do |label, item|
        html << render_admin_menu_item(label, item)
      end
      raw html.join
    end
  end

  private

  def render_admin_menu_item(label, item)
    html = []
    html << link_to(item[:submenu] ? "#" : item[:url]) do
      tmp = []
      tmp << content_tag(:i, class: "icon icon-#{item[:icon]}"){ "" } if item[:icon]
      tmp << label
      raw tmp.join      
    end
    html << render_admin_menu(item[:submenu]) if item[:submenu]
    actived = item[:match] ? request.original_url =~ item[:match] : false
    content_tag(:li, class: "#{item[:submenu] ? "submenu " : ""}#{actived ? "active open" : ""}") do
      raw html.join
    end
  end
end