require_relative 'day'
require 'io/console'

class D18 < Day

	SIDE=100
	STEPS=100

	def to_idx(x,y)
		y * SIDE + x
	end

	def val_at(grid,x,y)
		if (x < 0 || x >= SIDE || y < 0 || y >= SIDE)
			false
		else
			grid[to_idx(x,y)]
		end
	end

	def neighbours(grid,x,y)
		[].tap do |vals|
			(-1..1).each do |y_off|
				(-1..1).each do |x_off|
					vals << val_at(grid,x + x_off, y + y_off)
				end
			end
			vals.delete_at(4)
		end
	end

	def print_grid(grid)
		(0...SIDE).each do |y|
			(0...SIDE).each do |x|
				print (grid[to_idx(x,y)] ? '#' : '.')
			end
			print "\n"
		end
	end

	def next_grid(source_grid,stuck=[])
		Array.new(SIDE ** 2, false).tap do |grid|
			(0...SIDE).each do |y|
				(0...SIDE).each do |x|
					n = neighbours(source_grid,x,y)
					if n.count(&:itself) == 3 || (n.count(&:itself) == 2 && val_at(source_grid,x,y)) || stuck.include?([x,y])
						grid[to_idx(x,y)] = true
					end
				end
			end
		end
	end

	def wait
		puts "Press any key to continue..."
		STDIN.getch
	end

	def part_one
		grid = @lines.join("").chars.map{|c| c == '#'}
		require 'pry'
		binding.pry unless grid.size == SIDE ** 2

		STEPS.times do	
			grid = next_grid(grid)
		end
		puts "There are #{grid.count(&:itself)} lights on after 100 steps"
	end

	def part_two
		stuck = [[0,0],[0,SIDE-1],[SIDE-1,0],[SIDE-1,SIDE-1]]
		grid = @lines.join("").chars.map{|c| c == '#'}
		grid[0] = true
		grid[SIDE-1] = true
		grid[-1] = true
		grid[-SIDE] = true

		STEPS.times do
			grid = next_grid(grid,stuck)
		end
		puts "There are #{grid.count(&:itself)} lights on after 100 steps"
	end

end
