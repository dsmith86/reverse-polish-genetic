# Public: Translates a binary string into instructions that can be interpreted
# in Reverse Polish Notation (RPN). Operands 0-9 are pushed to a stack, and
# operators {+, -, *, /} are added to a separate queue. Errors are tracked
# and can optionally be retrieved.
class RPNCalculator
	# Public: Returns the errors encountered during calculations.
	attr_reader :errors

	# Public: Initialize the RPN Calculator.
	#
	# instructions - An array of intructions to be converted to RPN expression.
	def initialize(instructions)
		@operands = Array.new
		@operators = Array.new
		@errors = Array.new
		@instructions = instructions
	end

	# Public: Calculates the RPN expression by popping operands off of their
	# stack in pairs of two and applying the operator removed from their queue.
	#
	# Returns an array containing the last element of the operands stack as well
	#   as a boolean value indicating whether there were errors. Assuming that
	#   there are no errors, the last element of the operands stack should be the
	#   only element.
	#   Alternately returns [0, false] prematurely if there are no operands.
	def calculate
		place_in_containers()

		# Checks for mismatch between the number of operands and operators.
		# The only valid number of operators for N operands is (N - 1).
		unless @operands.size - @operators.size == 1
			@valid = false
			@errors.push("Operand/Operator mismatch.")
		end

		# Checks for operators present before the first two operands
		# are written. This is incorrect RPN syntax.
		if (@instructions[0..1] & [1010, 1011, 1100, 1101]).any?
			@valid = false
			@errors.push("Operator present before first two operands.")
		end

		# Checks for an empty operand stack. In this case, there is
		# nothing more to do in the method.
		if @operands.empty?
			@errors.push("No operands.")
			return [0, false]
		end

		# Runs a loop until fewer than two operands or fewer than 1
		# operators are present in their respective containers.
		until @operands.size == 1 || @operators.size == 0 do
			# Pops the first operator from the front of the queue.
			operator = @operators.shift

			# Pops the top and second-to-top operands off of the stack.
			opright = @operands.pop
			opleft = @operands.pop

			# Returns prematurely before division by zero occurs.
			if operator == "/" && opright == 0
				puts "division by zero"
				return [0, false]
			end

			# Sends the operator and the right operand to the left operand
			# and thereby invokes FixedNum#+, the method used for adding
			# integers.
			@operands.push(opleft.send(operator, opright))
		end

		# Returns the last element of @operands and the value of @valid.
		[@operands[-1], @valid]
	end

	def place_in_containers
		@valid = true

		@instructions.each do | instr |
			case instr
      		# first case: number 0-9
			when 0, 1, 10, 11, 100, 101, 110, 111, 1000, 1001
	        # Convert instr to string temporarily so that the to_i method can be
	        # invoked. The resultant decimal value can then be pushed to the
	        # operators stack.
				@operands.push(instr.to_s.to_i(2))
      		# other cases: symbols
			when 1010
        	# Array#unshift pushes the operators to the back of the queue.
				@operators.unshift("+")
			when 1011
				@operators.unshift("-")
			when 1100
				@operators.unshift("*")
			when 1101
				@operators.unshift("/")
			else
				@errors.push(%(Unknown Instruction "#{instr}".))
				@valid = false
			end
		end
	end

	private :place_in_containers
end