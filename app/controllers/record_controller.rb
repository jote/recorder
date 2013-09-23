class RecordController < ApplicationController

 def self.record
   ReserveFile.find_all.each do |reserve_file|
     reserve = ReserveFile.load reserve_file
     program = self.get_program reserve
     next unless program
     now = DateTime.now
     record_time = program.start_time.to_datetime - Rational(1, 24 * 60) #before 1 minite
     record_past_time = record_time + Rational(5, 24 * 60)
     if (now <=> record_time) >= 0
       if (record_past_time <=> now) >= 0
         puts "record #{reserve_file}"
         FileUtils.mv(reserve_file, "#{reserve_file}d")
         Rectpt1Controller::record(reserve, program)
       end
     end
   end
 end

 def self.get_program reserve
   begin
     return Programs.find reserve.program_id
   rescue ActiveRecord::RecordNotFound => e
     puts e
   end
   return false
 end

end
