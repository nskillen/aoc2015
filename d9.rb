require_relative 'day'

class D9 < Day

	def part_one
		distances = {}
		@lines.each do |l|
			m = /(\w+) to (\w+) = (\d+)/.match(l)
			from, to, dist = m[1..-1]
			distances[from] ||= {}
			distances[from][to] = dist.to_i
			distances[to] ||= {}
			distances[to][from] = dist.to_i
		end

		shortest_path = {dist: 10000000, path: nil}
		@longest_path = {dist: 0, path: nil}
		distances.keys.permutation.each do |path|
			pdist = 0
			path.each_cons(2) do |from,to|
				pdist += distances[from][to]
			end
			if shortest_path[:dist] > pdist
				shortest_path[:dist] = pdist
				shortest_path[:path] = path
			end
			if @longest_path[:dist] < pdist
				@longest_path[:dist] = pdist
				@longest_path[:path] = path
			end
		end
		puts "The shortest path is #{shortest_path[:dist]} miles long, and the route is:\n#{shortest_path[:path].join(" -> ")}"
	end

	def part_two
		puts "The longest path is #{@longest_path[:dist]} miles long, and the route is:\n#{@longest_path[:path].join(" -> ")}"
	end

end
