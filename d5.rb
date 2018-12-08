require_relative 'day'

class D5 < Day

	def part_one
		nice = @lines.select do |l|
			/.*[aeiou].*[aeiou].*[aeiou].*/ =~ l &&
				/([a-z])\1/ =~ l &&
				/ab|cd|pq|xy/ !~ l
		end
		puts "There are #{nice.size} nice strings"
	end

	def part_two
		nice = @lines.select do |l|
			/([a-z]{2}).*\1/ =~ l &&
				/([a-z])(?:(?!\1)[a-z])\1/ =~ l
		end
		puts "There are #{nice.size} nice strings"
	end

end
