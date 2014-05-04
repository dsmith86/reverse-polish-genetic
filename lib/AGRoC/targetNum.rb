# Public: Generates a random number and a corresponding bit sequence that
# are determined by the number of operands needed. A bit sequence will
# be passed to and handled by the RPNCalculator class and can then be
# compared to the target number.

class TargetNumber
	# Public: Returns the bit count needed to perform calculations.
	attr_reader :bit_count
	attr_reader :errors_from_calculator

	# Public: Initialize a Target Number. Generate a random number in the correct
	# range and calculate the bit_count needed.
	#
	# operands_in_sequence - The total number of operands in the operation.
	def initialize(operands_in_sequence = 2)
		@errors_from_calculator = Array.new
		@operands_in_sequence = operands_in_sequence
		@target = random_target
		@bit_count = 4 * (@operands_in_sequence * 2 - 1)
	end

	# Public: Returns an array containing the absolute value of the difference of
	# the input sequence and the target number. The second element in the array
	# is a boolean value that is true only if the input sequence was validated
	# by the RPNCalculator class. Extra operands or operators are ignored, the
	# best possible answer is calculated using the remaining instructions, and
	# the boolean value is set to false if the input sequence does not conform to
	# RPN specifications. In the case of division by zero, [0, false] is
	# returned from RPNCalculator.
	#
	# input_sequence - A sequence of binary digits to be interpreted by the
	#                 RPNCalculator class.
	#
	# Examples
	#
	#   diff_from_target(100100111011)
	#   # => [6, true]
	#
	#   diff_from_target(010111101100101000011001011001101111)
	#   # => [108, false]
	#
	#   diff_from_target(11101010011000100010)
	#   # => [4, false]
	def diff_from_target(input_sequence)
		results = translate(input_sequence)

		diff = (@target - results[0]).abs

		[diff, results[1]]
	end

	# Internal: Returns a random number in the correct range.
	def random_target
		# The greatest possible target number is achieved when each operand is 9
		# and each operator is *.
		rand(0..(9 ** @operands_in_sequence))
	end

	# Internal: Maps groups of 4 from the input sequence to an array. Creates
	# an instance of the RPNCalculator class and passes the array of
	# instructions. Calls the calculate method.
	#
	# Returns the array [result, valid].
	def translate(input_sequence)
		require_relative "RPNCalc"
		instructions =  input_sequence.to_s.scan(/..../).map { |e| e.to_i }
		calculator = RPNCalculator.new(instructions)

		@errors_from_calculator = calculator.errors

		calculator.calculate
	end

	private :random_target, :translate
end