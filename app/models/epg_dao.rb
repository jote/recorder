class EpgDao
  def initialize(path)
    begin
      @xml = REXML::Document.new(open(path))
      @ch_id = File.basename(path, '.xml').to_i
      @programs = []
      @channel = ChannelDao.new(@ch_id, @xml)
      set_programs
    rescue ChannelDaoException => e
      raise EpgDaoException.new(e)
    rescue ProgramDaoException => e
      raise EpgDaoException.new(e)
    end
  end
  attr_reader :channel, :programs, :name

  def set_programs
    @xml.elements.each('tv/programme') do |pg|
      @programs << ProgramDao.new(pg, @ch_id)
    end
  end
end

class EpgDaoException < Exception
end
