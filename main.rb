require_relative 'simulator'

sim = Simulator.new
puts "~> Enter a input, Valid commands are:\n~> place x,y,(north|south|east|west), exit, move, left, right, report"
input = STDIN.gets

while input
  input = input.downcase.strip
  if input == "exit"
    puts "***exiting the Simulator***"
    exit
  else
    output = sim.perform(input)
    puts output if output
    input = STDIN.gets
  end

end
