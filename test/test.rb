require_relative "../lib/AGRoC/targetNum.rb"

target = TargetNumber.new(3)

# Create random binary sequence using the target's bit count
chromosomes = (0...target.bit_count).map { rand(0..1) }.join
puts chromosomes

diff = target.diff_from_target(chromosomes)

puts "Diff:"
puts diff[0]

puts "Valid:"
puts diff[1]

puts "ERRORS:"
puts target.errors_from_calculator
