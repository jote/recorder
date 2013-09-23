class ReserveController < ApplicationController

  def self.reserve
    ReserveWords.words.each do |word|
      puts "search #{word}"
      programs = Programs.where("title like ?", "%#{word}%" )
      programs.each do |program|
        path = ReserveFile.path program
        next if File.exist? path
        ReserveFile.find_same_id(program.id).each do |reserve|
          puts "delete #{reserve}"
          File.delete(reserve)
        end
        puts "create #{path}"
        File.open(path, 'w').puts(program.title)
      end
    end
  end

  def self.reserve_by id
      puts "search #{id}"
      program = Programs.find(id)
        path = ReserveFile.path program
        return true if File.exist? path
        ReserveFile.find_same_id(program.id).each do |reserve|
          puts "delete #{reserve}"
          File.delete(reserve)
        end
        puts "create #{path}"
        File.open(path, 'w').puts(program.title)
  end

  def self.search word
      puts "search #{word}"
      programs = Programs.where("title like ?", "%#{word}%" )
      programs.each do |program|
        puts "#{program.title} #{program.id} #{program.start_time} #{program.end_time}"
      end
  end

end
