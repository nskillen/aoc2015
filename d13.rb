require_relative 'day'

class D13 < Day

	def part_one
		@happiness_change = {:me => {}}
		@lines.each do |line|
			m = /(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)\./.match(line)
			pa,gl,amt,pb = m[1..-1]
			@happiness_change[pa] ||= {}
			@happiness_change[pa][pb] = amt.to_i * (gl == 'gain' ? 1 : -1)
			@happiness_change[pa][:me] = 0
			@happiness_change[:me][pa] = 0
		end

		max_happy = {ord: nil, amt: 0}
		(@happiness_change.keys - [:me]).permutation.each do |ord|
			hap = ord.each_cons(2).map{|a,b| @happiness_change[a][b] + @happiness_change[b][a]}.reduce(0,&:+)
			hap += @happiness_change[ord.first][ord.last] + @happiness_change[ord.last][ord.first]
			if hap > max_happy[:amt]
				max_happy[:amt] = hap
				max_happy[:ord] = ord
			end
		end
		puts "Maximum happiness is achieved at a value of #{max_happy[:amt]} with the following ordering:\n#{max_happy[:ord].join(", ")}"
	end

	def part_two
		max_happy = {ord: nil, amt: 0}
		@happiness_change.keys.permutation.each do |ord|
			hap = ord.each_cons(2).map{|a,b| @happiness_change[a][b] + @happiness_change[b][a]}.reduce(0,&:+)
			hap += @happiness_change[ord.first][ord.last] + @happiness_change[ord.last][ord.first]
			if hap > max_happy[:amt]
				max_happy[:amt] = hap
				max_happy[:ord] = ord
			end
		end
		puts "Maximum happiness is achieved at a value of #{max_happy[:amt]} with the following ordering:\n#{max_happy[:ord].join(", ")}"
	end

end
