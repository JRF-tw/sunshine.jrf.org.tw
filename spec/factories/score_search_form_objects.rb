FactoryGirl.define do
  factory :score_search_form_object, class: Score::SearchFormObject do
    skip_create
    score_type_eq ''
    judge_id_eq ''
    story_id_eq ''
    rater_type_eq ''
    rater_id_eq ''
    created_at_gteq ''
    created_at_lteq ''
  end
end
