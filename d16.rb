require_relative 'day'

class D16 < Day

	Sue = Struct.new(:num,:children,:cats,:samoyeds,:pomeranians,:akitas,:vizslas,:goldfish,:trees,:cars,:perfumes, keyword_init: true)

	KNOWN = {
		children: 3,
		cats: 7,
		samoyeds: 2,
		pomeranians: 3,
		akitas: 0,
		vizslas: 0,
		goldfish: 5,
		trees: 3,
		cars: 2,
		perfumes: 1,
	}

	def part_one
		@sues = []
		@lines.each do |line|
			m = /Sue (\d+): (.+)/.match(line)
			likes = m[2].split(", ").map{|e| e.split(": ")}.map{|k,v| [k.to_sym,v.to_i]}.to_h
			@sues << Sue.new({num: @sues.size + 1, **likes})
		end

		sue = @sues.detect{|s| KNOWN.keys.all?{|k| s[k].nil? || s[k] == KNOWN[k]}}
		if sue.nil?
			puts "I don't know which aunt it was!"
		else
			puts "Thanks for the gift, Sue ##{sue.num}"
		end
	end

	def part_two
		sue = @sues.detect { |s|
			KNOWN.keys.all? { |k|
				s[k].nil? || case k
				when :cats, :trees           then s[k] > KNOWN[k]
				when :pomeranians, :goldfish then s[k] < KNOWN[k]
				else                              s[k] == KNOWN[k]
				end
			}
		}
		if sue.nil?
			puts "I don't know which aunt it was!"
		else
			puts "Thanks for the gift, Sue ##{sue.num}"
		end
	end

end
