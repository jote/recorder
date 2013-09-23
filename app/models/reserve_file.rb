class ReserveFile
  RESERVE_DIR = Rails.root.join('tmp')
  START_TIME_COLUMN_NUM = 0
  PROGRAM_ID_COLUMN_NUM = 1

  def self.find_same_id id
    Dir.glob(File.join(RESERVE_DIR,"*#{id}.reserve"))
  end

  def self.path program
    start_timestamp = program.start_time.strftime('%Y%m%d%H%M%S')
    File.join(RESERVE_DIR, "#{start_timestamp}_#{program.id}.reserve")
  end

  def self.find_all
    Dir.glob(File.join(RESERVE_DIR,"*.reserve"))
  end

  def initialize(start_timestamp, program_id, title)
    @start_timestamp = start_timestamp
    @program_id = program_id
    @title = title
  end
  attr_reader :start_timestamp, :program_id, :title

  def self.load path
    element = File.basename(path, '.reserve').split('_')
    title = File.open(path, 'r').read.chomp
    self.new(element[START_TIME_COLUMN_NUM], element[PROGRAM_ID_COLUMN_NUM].to_i, title)
  end
end
