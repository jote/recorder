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

# 出力先のログファイルの指定
set :output, File.join(Whenever.path, 'log/crontab.log')
# ジョブの実行環境の指定
#set :environment, :development
set :environment, :production

every '* * * * *' do
  rake "recpt1:record"
end

every '0 7,10 * * *' do
  rake "channel:scan"
end

every '0 8,11 * * *' do
  rake "channel:reserve"
end
