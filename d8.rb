require_relative 'day'

class D8 < Day

	def part_one
		code = 0
		chars = 0
		@lines.each do |l|
			co = l.size
			ch = l.gsub(/\\\\|\\"|\\x\h\h/, "?").size - 2 # -2 for the begin/end quotes
			code += co
			chars += ch
		end
		puts "The difference between code and chars is #{code - chars}"
	end

	def part_two
		encoded = 0
		orig = 0
		@lines.each do |l|
			orig += l.size
			enc = l.gsub(/(\\|\")/, "\\\\1")
			encoded += enc.size + 2 # for new boundary quotes
			#puts "[[ #{l} ]] orig: #{l.size}, enc: #{enc.size}"
		end
		puts "The difference between the original and re-encoded strings is #{encoded - orig}"
	end

end
