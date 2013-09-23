class ProgramDao

  def initialize(xml, channels_id)
    begin
      @id = xml.attributes['event_id'].to_i
      @duration = xml.attributes['duration'].to_i
      @title = xml.elements['title'].text
      @desc = xml.elements['desc'].text
      @aspect = xml.elements['video/aspect'].text
      category_ids = []
      xml.elements.each('category') do |category|
          name = category.text
          record = Category.find_or_create_by_name(name)
          category_ids << record.id
      end
      @categories = category_ids.join(',')
      @start_time = parse_time(xml.attributes['start'].gsub(' +0900', ''))
      @end_time = parse_time(xml.attributes['stop'].gsub(' +0900', ''))
      @channels_id = channels_id.to_i
    rescue  => e
     raise ProgramDaoException.new e
    end
  end
  attr_reader :id, :duration, :title, :desc, :aspect, :categories, :start_time, :end_time, :channels_id

  def parse_time(str)
    year = str[0..3].to_i
    month = str[4..5].to_i
    day = str[6..7].to_i
    h = str[8..9].to_i
    m = str[10..11].to_i
    s = str[12..13].to_i
    DateTime.new(year, month, day, h, m, s)
  end
end

class ProgramDaoException < Exception
end
