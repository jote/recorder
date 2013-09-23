class Rectpt1Controller < ApplicationController
  RECT_PATH = '/usr/local/bin/recpt1'
  TS_DIR_PATH = Rails.root.join('videos')

  def self.record(reserve, program)
      ts = File.join(TS_DIR_PATH, "#{reserve.start_timestamp}_#{program.channels_id}_#{reserve.title}.ts")
      cmd = self.get_cmd(program, ts)
      puts cmd
      logger.info(cmd)
      system cmd
  end

  def self.get_cmd(program, ts)
    channels_id = ChannelDao.get_cs_id(program.channels_id)
    if channels_id
      return "#{RECT_PATH}  --b25 --strip C#{channels_id} #{program.duration} #{ts}"
    else
      return "#{RECT_PATH}  --b25 --strip #{program.channels_id} #{program.duration} #{ts}"
    end
  end
end
