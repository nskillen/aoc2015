require_relative 'day'
require 'json'

class D12 < Day

	def sum_json json
		if json.is_a?(Array)
			json.map{|el| sum_json(el)}.reduce(0, &:+)
		elsif json.is_a?(Hash)
			return 0 if json.values.include?("red")
			json.values.map{|el| sum_json(el)}.reduce(0, &:+)
		elsif json.is_a?(String)
			0
		elsif json.is_a?(Integer)
			json
		else
			raise "Unrecognized type #{json.class.name}: #{json.to_s}"
		end
	end

	def part_one
		puts "The total sum is #{@input.scan(/-?\d+/).map(&:to_i).reduce(0,&:+)}"
	end

	def part_two
		json = JSON.parse(@input)
		puts "The total (excluding reds) is #{sum_json(json)}"
	end

end
