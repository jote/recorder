class ChScannerController < ApplicationController
  RECT_PATH = '/usr/local/bin/recpt1'
  EPGDUMP_PATH = '/usr/local/bin/epgdump'
  TS_DIR_PATH = Rails.root.join('tmp/ts')
  XML_DIR_PATH = Rails.root.join('tmp/xml')

  def scan
    FileUtils.mkdir(TS_DIR_PATH) unless File.exist?(TS_DIR_PATH)
    FileUtils.mkdir(XML_DIR_PATH) unless File.exist?(XML_DIR_PATH)
    FileUtils.rm(Dir.glob("#{XML_DIR_PATH}/*"))
    FileUtils.rm(Dir.glob("#{TS_DIR_PATH}/*"))
    # CATV放送だった
    #tijo_scan
    catv_scan
  end

  def tijo_scan
    ch = 12
    duration = 4
    while ch < 63
      ch += 1
      ts = File.join(TS_DIR_PATH, "scan_#{ch}.ts")
      ch_xml = File.join(XML_DIR_PATH, "#{ch}.xml")
      puts "channel scan: #{ch}"
      logger.info "channel scan: #{ch}"
      `#{RECT_PATH} #{ch} #{duration} #{ts}`
      next unless File.exist?(ts)
      `#{EPGDUMP_PATH} #{ts} #{ch_xml}`
      begin
        @epg = EpgDao.new(ch_xml)
        register
      rescue EpgDaoException => e
        puts e
        logger.error e
      end
    end
  end

  def catv_scan
    ch = 1012
    duration = 4
    while ch < 1064
      ch += 1
      ts = File.join(TS_DIR_PATH, "scan_#{ch}.ts")
      ch_xml = File.join(XML_DIR_PATH, "#{ch}.xml")
      puts "channel scan: C#{ChannelDao::get_cs_id ch}"
      logger.info "channel scan: C#{ChannelDao::get_cs_id ch}"
      puts "#{RECT_PATH} C#{ChannelDao::get_cs_id ch} #{duration} #{ts}"
      `#{RECT_PATH} C#{ChannelDao::get_cs_id ch} #{duration} #{ts}`
      next unless File.exist?(ts)
      `#{EPGDUMP_PATH} #{ts} #{ch_xml}`
      begin
        @epg = EpgDao.new(ch_xml)
        register
      rescue EpgDaoException => e
        puts e
        logger.error e
      end
    end
  end

  def register
    @epg.programs.each do |pg|
      if Programs.exists?(pg.id)
        Programs.update_changes(pg)
      else
        Programs.create_with_dao(pg)
      end
    end
  end
end
