require_relative 'day'

class D7 < Day


	Gate = Struct.new(:a1,:a2,:op,:d,:done) do
		@@wires = nil
		def self.wires= wires
			@@wires = wires
		end

		def can_do
			((op == 'NOT' || op.nil?) && val(a2)) || (val(a1) && val(a2))
		end

		def undone
			self.done = false
		end

		def perform
			self.done = true
			case op
			when nil      then @@wires[d] = val(a2) # direct assignment wire-to-wire
			when 'AND'    then @@wires[d] = val(a1) & val(a2)
			when 'OR'     then @@wires[d] = val(a1) | val(a2)
			when 'NOT'    then @@wires[d] = ~val(a2)
			when 'LSHIFT' then @@wires[d] = (val(a1) << val(a2)) & 0xFFFF
			when 'RSHIFT' then @@wires[d] = (val(a1) >> val(a2)) & 0xFFFF
			else raise "Unknown op '#{op}'"
			end
		end

		private def val k
			if k.to_i.to_s == k
				k.to_i
			else
				@@wires[k]
			end
		end
	end

	def part_one
		@wires = {}
		Gate.wires = @wires

		@gates = []

		@lines.each do |l|
			if /(?:(?:(?<arg1>.+) )?(?<op>AND|OR|LSHIFT|RSHIFT|NOT) )?(?<arg2>.+) -> (?<dest>.+)/ =~ l
				if op.nil? # direct assignment
					if arg2.to_i.to_s == arg2 # val-to-wire
						@wires[dest] = arg2.to_i
					else
						@gates << Gate.new(nil,arg2,nil,dest,false)
					end
				else
					@gates << Gate.new(arg1,arg2,op,dest,false)
				end
			end
		end

		until @gates.all?(&:done)
			todo = @gates.reject(&:done).select(&:can_do)
			todo.each {|g| g.perform}
		end

		puts "The value on wire 'a' is #{@wires['a']}"
	end

	def part_two
		@gates.each(&:undone)
		b_val = @wires['a']
		@wires.clear
		@wires['b'] = b_val
		@wires['c'] = 0
		until @gates.all?(&:done)
			@gates.reject(&:done).select(&:can_do).each(&:perform)
		end
		puts "The value on wire 'a' is #{@wires['a']}"
	end

end
