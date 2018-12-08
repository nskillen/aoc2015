require_relative 'day'

class D3 < Day
	def deliver(x,y)
		@deliveries["#{x},#{y}"] ||= 0
		@deliveries["#{x},#{y}"] += 1
	end

	def part_one
		@deliveries = {}
		pos = [0,0]

		deliver(*pos)
		@input.strip.chars.each do |c|
			case c
			when '>' then pos[0] += 1
			when '<' then pos[0] -= 1
			when 'v' then pos[1] += 1
			when '^' then pos[1] -= 1
			else raise "Unexpected character '#{c}'"
			end
			deliver(*pos)
		end
		puts "Santa delivered to #{@deliveries.keys.size} separate houses this year"
	end

	def part_two
		@deliveries = {}
		s_pos = [0,0]
		r_pos = [0,0]

		deliver(*s_pos)

		@input.strip.chars.each_slice(2) do |s,r|
			case s
			when '>' then s_pos[0] += 1
			when '<' then s_pos[0] -= 1
			when 'v' then s_pos[1] += 1
			when '^' then s_pos[1] -= 1
			else raise "Unexpected character '#{c}'"
			end
			case r
			when '>' then r_pos[0] += 1
			when '<' then r_pos[0] -= 1
			when 'v' then r_pos[1] += 1
			when '^' then r_pos[1] -= 1
			else raise "Unexpected character '#{c}'"
			end
			deliver(*s_pos)
			deliver(*r_pos)
		end
		puts "Santa and Robot Santa delivered to #{@deliveries.keys.size} separate houses this year"
	end

end
