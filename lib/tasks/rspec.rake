namespace :spec do

  RSpec::Core::RakeTask.new(:nofeatures) do |task|
    file_list = FileList['spec/**/*_spec.rb']

    %w(features).each do |exclude|
      file_list = file_list.exclude("spec/#{exclude}/**/*_spec.rb")
    end

    task.pattern = file_list
  end

end

# CI scripts:
# xvfb-run -a bundle exec rake spec:nofeatures
# bundle exec rubocop
# git clone --branch gh-pages git@github.com:5fpro/jrf-sunny.git ./live-document
# bundle exec rspec --format html --order defined --out ./live-document/"${CI_BRANCH}".html ./spec/features/
# cd live-document
# git add .
# ts=$(date +"%Y-%m-%d %T")
# git config user.name 'CodeShip'
# git config user.email 'codeship@5fpro.com'
# git commit -m "'CI at ${ts} --skip-ci'"
# git push origin gh-pages
# json="{\"text\":\"Live doc: http://5fpro.github.io/jrf-sunny/${CI_BRANCH}.html for ${CI_BRANCH}\",\"username\": \"CodeShip\",\"channel\": \"#ci-server\",\"icon_url\": \"https://a.slack-edge.com/7bf4/img/services/codeship_48.png\"}"
# curl -H "Content-type: application/json" -X POST -d "${json}" https://hooks.slack.com/services/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
