class Channels < ActiveRecord::Base
  has_many :programs

  def self.find_or_create(id)
    if self.exists?(id)
      return self.find(id)
    else
      channel =  self.new
      channel.id = id
      return channel
    end
  end
end
