class Programs < ActiveRecord::Base
  belongs_to :channels

  def self.create_with_dao(dao)
    program = self.new do |record|
      record.id = dao.id
      record.desc = dao.desc
      record.title = dao.title
      record.start_time = dao.start_time
      record.end_time = dao.end_time
      record.duration = dao.duration
      record.aspect = dao.aspect
      record.categories = dao.categories
      record.channels_id = dao.channels_id
    end
    program.save
  end

  def self.get_category_ids(categories)
    ids = []
    categories.each do |c|
      category = Category.find_or_create_by_name(c)
      ids << category.id
    end
    ids
  end

  def self.update_changes(dao)
    record = self.find(dao.id)
    unless self.same?(record, dao)
      record.desc = dao.desc
      record.title = dao.title
      record.start_time = dao.start_time
      record.end_time = dao.end_time
      record.duration = dao.duration
      record.aspect = dao.aspect
      record.categories = dao.categories
      record.channels_id = dao.channels_id
      record.save
    end
  end

  def self.same?(record, dao)
    if (record.desc == dao.desc &&
        record.title == dao.title &&
        record.start_time == dao.start_time &&
        record.end_time == dao.end_time &&
        record.duration == dao.duration &&
        record.aspect == dao.aspect &&
        record.channels_id == dao.channels_id &&
        record.categories == dao.categories)
      return true
    end
    false
  end

end
