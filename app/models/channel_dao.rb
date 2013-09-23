class ChannelDao
  CS_DEFAULT_NUMBER = 1000

  def initialize(id, xml)
    @id = id
    raise ChannelDaoException.new("Nothing channel xml elements")  if xml.elements['tv/channel/display-name'].nil?
    @name = xml.elements['tv/channel/display-name'].text
  end
  attr_reader :id, :name

  def self.get_cs_id id
    return false if id < CS_DEFAULT_NUMBER
    id - CS_DEFAULT_NUMBER
  end
end

class ChannelDaoException < Exception
end
