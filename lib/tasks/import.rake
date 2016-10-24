namespace :import do
  task :lawyer, [:arg1] => :environment do |_t, args|
    puts '匯入律師資料中...'
    context = Import::GetLawyerContext.new(args[:arg1])
    context.perform
    puts "成功匯入 #{context.import_lawyers.count} 筆"
    puts "失敗匯入共 #{context.error_message.count} 筆"
    puts "律師email重複 #{context.error_message.select { |a| a[:lawyer_exist] }.count} 筆"
    puts "缺少 姓名 #{context.error_message.select { |a| a[:lawyer_name_blank] }.count} 筆"
    puts "缺少 email #{context.error_message.select { |a| a[:lawyer_email_blank] }.count} 筆"
    puts "儲存失敗 #{context.error_message.select { |a| a[:lawyer_create_fail] }.count} 筆"
  end
end
