require_relative 'day'

class D14 < Day

	R = Struct.new(:name,:spd,:end,:rst,:dst,:pts) do
		include Comparable
		def <=> other
			dst <=> other.dst
		end
	end

	def part_one
		@deers = []
		@lines.each do |line|
			m = /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\./.match(line)
			name = m[1]
			spd,endu,rst = m[2..-1].map(&:to_i)
			@deers << R.new(name,spd,endu,rst,0,0)
		end

		t = 0
		until t == 2503 do
			@deers.each do |d|
				dt = t % (d.end + d.rst)
				d.dst += d.spd if dt < d.end
			end
			lead = @deers.max.dst
			@deers.select{|d| d.dst == lead}.each{|d| d.pts += 1}
			t += 1
		end

		puts "The max distance travelled was by #{@deers.max.name}, who travelled #{@deers.max.dst} kms"
	end

	def part_two
		winner = @deers.sort{|a,b| a.pts <=> b.pts}.last
		puts "The reindeer with the most points is #{winner.name} with #{winner.pts} points"
	end

end
