require_relative 'table'
require_relative 'robot'

class Simulator
  def initialize
    puts "~> setting up simulator"
    @table = Table.new 5,5
    @robot = Robot.new @table
  end

  def perform input
    begin
      @robot.evaluate(input)
    rescue StandardError => error
      puts error.message
    end
  end
end
