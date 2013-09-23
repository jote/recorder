namespace :channel do
  desc "チャンネルスキャン毎朝実行"

  task :scan => :environment do
    ctl = ChScannerController.new
    ctl.scan
  end
end

namespace :channel do
  desc "番組予約"

task :reserve, 'program_id'
  task :reserve => :environment do |t, args|
    if args.program_id.nil?
      ctl = ReserveController.reserve
    else
      ctl = ReserveController.reserve_by args.program_id.to_i
    end
  end
end

namespace :channel do
  desc "番組検索"

task :search, 'word'
  task :search => :environment do |t, args|
    ReserveController.search args.word
  end
end

namespace :channel do
  desc "番組リスト"

  task :programs => :environment do
      limit_time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      sql = "SELECT channels_id, title, start_time, end_time FROM programs WHERE start_time >= \"#{limit_time}\" order by start_time"
      Programs.find_by_sql(sql).each do |p|
        puts "#{p.start_time} #{p.end_time} #{p.title} #{p.id}"
      end
  end
end
