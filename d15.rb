require_relative 'day'

class D15 < Day

	T = Struct.new(:name,:cap,:dur,:flv,:tex,:cal)

	def score(toppings)
		raw_score = {cap: 0, dur: 0, flv: 0, tex: 0}
		raw_score.keys.each do |k|
			toppings.each do |t,amt|
				raw_score[k] += t[k] * amt
			end
			raw_score[k] = 0 if raw_score[k] < 0
		end
		raw_score.values.reduce(1, &:*)
	end

	def calories(toppings)
		cals = []
		toppings.each do |t,amt|
			cals << t.cal * amt
		end
		cals.reduce(0, &:+)
	end

	def part_one
		toppings = []
		@lines.each do |line|
			m = /(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/.match(line)
			name = m[1]
			cap,dur,flv,tex,cal = m[2..-1].map(&:to_i)
			toppings << T.new(name,cap,dur,flv,tex,cal)
		end
		
		best = {score: 0, recipe: nil}
		@best_cals = {score: 0, recipe: nil}
		(0..100).each do |u1|
			puts u1
			r = [[toppings[0],u1]]
			(0..(100-u1)).each do |u2|
				#puts "\t#{u2}"
				r << [toppings[1],u2]
				(0..(100-u1-u2)).each do |u3|
					r << [toppings[2],u3]
					(0..(100-u1-u2-u3)).each do |u4|
						r << [toppings[3],u4]
						cr = r.to_h
						s = score(cr)
						if best[:score] < s
							best[:score] = s
							best[:recipe] = cr
						end
						if calories(cr) == 500
							if @best_cals[:score] < s
								@best_cals[:score] = s
								@best_cals[:recipe] = cr
							end
						end
						r.pop
					end
					r.pop
				end
				r.pop
			end
			r.pop
		end

		puts "The best recipe has a score of #{best[:score]}, and uses the following:"
		best[:recipe].each do |ing,amt|
			puts "#{amt}g of #{ing.name}"
		end
	end

	def part_two
		puts "The best recipe has a score of #{@best_cals[:score]}, and uses the following:"
		@best_cals[:recipe].each do |ing,amt|
			puts "#{amt}g of #{ing.name}"
		end
	end

end
