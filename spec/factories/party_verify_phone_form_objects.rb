FactoryGirl.define do
  factory :party_verify_phone_form_object, class: Party::VerifyPhoneFormObject do
    skip_create
    unconfirmed_phone '0922887817'
    phone_varify_code '1111'
    initialize_with { new(FactoryGirl.create(:party)) }
  end

end
