require_relative 'day'

class D1 < Day

	def part_one
		floor = 0
		count = 0
		@input.strip.chars.compact.each do |c|
			count += 1
			case c
			when '(' then floor += 1
			when ')' then floor -= 1
			else raise "Unexpected char '#{c}'"
			end
			if floor == -1
				@basement ||= count
			end
		end
		puts "The final floor is #{floor}"
	end

	def part_two
		puts "Santa enters the basement on char #{@basement}"
	end

end
