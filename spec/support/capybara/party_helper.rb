module Capybara
  module PartyHelper
    def capybara_signin_party(party)
      visit(new_party_session_path)
      within("#new_party") do
        fill_in "party_identify_number", with: party.identify_number
        fill_in "party_password", with: party.password
      end
      click_button "登入"
      party
    end
  end
end
