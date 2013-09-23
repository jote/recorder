class ReserveWords
  YAML_PATH = Rails.root.join('config/reserve_words.yml')

  def initialize
    @words = YAML.load_file(YAML_PATH)
  end
  attr_reader :words

  def self.words
    self.new.words
  end
end
