require_relative 'day'

class D2 < Day

	def part_one
		@dims = @lines.map{|l| /(\d+)x(\d+)x(\d+)/.match(l)[1..-1].map(&:to_i)}
		total = @dims.map{|l,w,h| 2*l*w + 2*l*h + 2*w*h + [l,w,h].sort.take(2).reduce(1,&:*)}.reduce(0,&:+)
		puts "The elves need #{total} sq ft of wrapping paper"
	end

	def part_two
		total = @dims.reduce(0) {|t,d| t + d.sort.take(2).map{|e| 2*e}.reduce(0,&:+) + d.reduce(1,&:*)}
		puts "The elves need a total of #{total} feet of ribbon"
	end

end
