namespace :recpt1 do
  desc "録画"

  task :record => :environment do
    ctl = RecordController.record
  end
end
