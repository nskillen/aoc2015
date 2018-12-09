require_relative 'day'

class D11 < Day

	def is_valid pwd
		has_seq = false
		pwd.chars.map(&:ord).each_cons(3){|a,b,c| has_seq ||= a + 1 == b && b + 1 == c}
		has_seq && pwd !~ /[iol]/ && /(\w)\1.*((?!\1)\w)\2/ =~ pwd
	end

	def next_pwd pwd
		np = pwd
		loop do
			idx = np.size
			np = np.chars.map(&:ord)
			while idx > 0
				idx -= 1
				np[idx] = np[idx]+1
				break unless np[idx] > "z".ord
				np[idx] = "a".ord
			end
			np = np.map(&:chr).join("")
			break if is_valid(np)
		end
		np
	end

	def part_one
		puts "The next password is #{@np = next_pwd("vzbxkghb")}"
	end

	def part_two
		puts "The next password is #{@np = next_pwd(@np)}"
	end

end
