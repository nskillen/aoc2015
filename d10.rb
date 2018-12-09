require_relative 'day'

class D10 < Day

	def next_seq seq
		out = ""
		char = nil
		count = nil
		seq.chars.each do |c|
			if c != char
				if char && count
					out << count.to_s
					out << char
				end
				char = c
				count = 1
			else
				count += 1
			end
		end
		out << count.to_s
		out << char
		out
	end

	def part_one
		@seq = "1321131112"
		40.times { @seq = next_seq(@seq) }
		puts "The result is #{@seq.size} characters long"
	end

	def part_two
		10.times { @seq = next_seq(@seq) }
		puts "The result is #{@seq.size} characters long"
	end

end
