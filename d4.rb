require_relative 'day'
require 'digest'

class D4 < Day

	def part_one
		md5 = ""
		n = 0
		until md5[0..4] == "00000"
			n += 1
			md5 = Digest::MD5.hexdigest("bgvyzdsv#{n}")
		end
		puts "The lowest number is #{n}"
	end

	def part_two
		md5 = ""
		n = 0
		until md5[0..5] == "000000"
			n += 1
			md5 = Digest::MD5.hexdigest("bgvyzdsv#{n}")
		end
		puts "The lowest number is #{n}"
	end

end
