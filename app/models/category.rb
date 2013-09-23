class Category < ActiveRecord::Base

  def self.find_or_create_by_name(name)
    record = self.find_by_name(name)
    if record.nil?
      record = self.create {|r| r.name = name}
    end
    record
  end
end
