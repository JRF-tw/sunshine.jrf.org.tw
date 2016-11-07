FactoryGirl.define do
  factory :party_change_phone_form_object, class: Party::ChangePhoneFormObject do
    skip_create
    unconfirmed_phone '0922887817'
    initialize_with { new(FactoryGirl.create(:party)) }
  end

end
