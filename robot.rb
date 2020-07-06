class Robot
  attr_reader :position, :direction, :table

  DIR = ["north", "east", "south", "west"]
  COMMANDS = ["place" ,"move" ,"left" ,"right" ,"report"]

  def initialize(table)
    raise 'Invalid table' if table.nil?
    @table = table
  end

  def place(x, y, dir)
    raise '!!! Invalid coordinates' if !((x.is_a? Integer) && (y.is_a? Integer))
    raise '!!! Please enter one of the four directions' if !(DIR.include?(dir))
    if valid_position?(x, y)
      @position = { x: x, y: y }
      @direction = dir
      return "$ Robot started from cordinates #{x},#{y} facing towards #{@direction}"
    else
      return "!!! Invalid_positions Cordinates x-axis=#{x},y-axis=#{y}"
    end
  end

  def move
    return "!!! Robot not found on table" if @position.nil? || @direction.nil?
    position = @position
    move = {}
    case @direction
    when "north"
      move = { x: 0, y: 1}
    when "east"
      move = { x: 1, y: 0}
    when "south"
      move = { x: 0, y: -1}
    when "west"
      move = { x: -1, y: 0}
    end
    if valid_position?(position[:x] + move[:x], position[:y] + move[:y])
      @position = { x: @position[:x] + move[:x], y: @position[:y] + move[:y] }
    return "moved"
    else
      return "!!! Bot can not move here because it is at #{@position[:x]},#{@position[:y]} and facing towards #{@direction}"
    end
  end

  def rotate_left
    return "not rotated" if @direction.nil?
    index = DIR.index(@direction)
    @direction = DIR[index-1]
    "rotated left"
  end

  def rotate_right
    return "not rotated" if @direction.nil?
    index = DIR.index(@direction)
    @direction = DIR[index+1]
    "rotated right"
  end

  def report
    if !(@position.nil? || @direction.nil?)
      return "The bot is on #{@position[:x]},#{@position[:y]} facing towards #{@direction}"
    else
      return "robot not found"
    end
  end

  def evaluate(input)
    return if input.strip.empty?
    args = input.split(" ")
    command = args.first.to_s
    arguments = args.last
    raise "Invalid input" if (arguments.nil? || !(COMMANDS.include?(command)))
    case command
    when "place"
      cordinates = arguments.split(/,/)
      raise "!!! Wrong number of arguments while intilaising position" unless cordinates.length == 3
      #considering any wront input n cordinates as 0
      x = cordinates[0].to_i
      y = cordinates[1].to_i
      direction = cordinates[2].downcase
      place(x, y, direction)
    when "report"
      report
    when "move"
      move
    when "right"
      rotate_right
    when "left"
      rotate_left
    else
      raise "Invalid command"
    end
  end

  private

  def valid_position?(x, y)
    (x >= 0 && x <= self.table.columns && y >= 0 && y <= self.table.rows)
  end

end
