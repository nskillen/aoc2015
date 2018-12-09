require_relative 'day'

class D17 < Day

	def part_one
		sizes = @lines.map(&:to_i)
		total = 0
		(1..sizes.count).each do |n|
			total += sizes.combination(n).select{|c| c.reduce(0,&:+) == 150}.count
		end
		puts "There are #{total} combinations of containers that can hold 150L of eggnog"
	end

	def part_two
		sizes = @lines.map(&:to_i)
		min = sizes.count
		total = 0
		(1..sizes.count).each do |n|
			break if n > min
			total = sizes.combination(n).select{|c| c.reduce(0,&:+) == 150}.count
			min = n if total > 0
		end
		puts "There are #{total} ways to pack 150L of eggnog into #{min} containers"
	end

end
