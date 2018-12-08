require_relative 'day'

class D6 < Day

	def part_one
		grid = Array.new(1000 * 1000, false)
		@lines.each do |l|
			m = /(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)/.match(l)
			action = m[1]
			fx,fy,tx,ty = m[2..-1].map(&:to_i)
			(fy..ty).each do |y|
				(fx..tx).each do |x|
					case action
					when 'turn on'  then grid[y * 1000 + x] = true
					when 'turn off' then grid[y * 1000 + x] = false
					when 'toggle'   then grid[y * 1000 + x] = !grid[y * 1000 + x]
					else raise "Unknown action '#{action}'"
					end
				end
			end
		end
		puts "There are #{grid.select(&:itself).size} lights lit"
	end

	def part_two
		grid = Array.new(1000 * 1000, 0)
		@lines.each do |l|
			m = /(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)/.match(l)
			action = m[1]
			fx,fy,tx,ty = m[2..-1].map(&:to_i)
			(fy..ty).each do |y|
				(fx..tx).each do |x|
					case action
					when 'turn on'  then grid[y * 1000 + x] += 1
					when 'turn off' then grid[y * 1000 + x] -= 1 if grid[y * 1000 + x] > 0
					when 'toggle'   then grid[y * 1000 + x] += 2
					else raise "Unknown action '#{action}'"
					end
				end
			end
		end
		puts "The total brightness is #{grid.reduce(0,&:+)}"
	end

end
