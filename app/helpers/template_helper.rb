module TemplateHelper
  def feature_card(heading, &block)
    content_tag :section, class: 'feature-card' do
      concat content_tag :h3, heading, class: 'feature-card__heading'
      concat capture &block
    end
  end
end