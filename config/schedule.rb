# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

if @environment == "production"
  every 1.day, :at => '5:00 am' do
    # sitemap generator
    rake "-s sitemap:refresh"
    # rake "sitemap:refresh:no_ping"
  end
end

# scrap courts
every 7.day, :at => '1:00 am' do
  runner "Scrap::ImportCourtContext.perform"
end

# scrap judges and branches
every 1.day, :at => '1:10 am' do
  runner "Scrap::ImportJudgeContext.perform"
end

# scrap schedules
every 1.day, :at => '1:30 am' do
  runner "Scrap::GetSchedulesContext.perform_all"
end

# scrap verdicts
every 1.day, :at => '2:00 am' do
  runner "Scrap::GetVerdictsContext.perform_all"
end
