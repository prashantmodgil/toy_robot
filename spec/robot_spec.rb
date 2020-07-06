describe "toy" do
  require_relative "../table"
  require_relative "../robot"
  require_relative "../simulator"
  before(:each) do
     @table = Table.new 5,5
     @robot = Robot.new @table
  end

  # invalid commands
  it 'should ignore invalid commands' do
    expect {  robot.evaluate("prashant") }.to raise_error(StandardError)
  end

  #placement_cases
   #postive
  it 'is placed correctly' do
    expect( @robot.place(0,1,"north")).to eq("$ Robot started from cordinates 0,1 facing towards north")
  end
  #negtive
  it 'is not placed correctly' do
    expect( @robot.place(6, 7, "west")).to eq("!!! Invalid_positions Cordinates x-axis=6,y-axis=7")
  end
  it 'should raise exceptions' do
    expect { @robot.place(nil, nil, "east") }.to raise_error(StandardError)
    expect { @robot.place(1, 0, "northeast") }.to raise_error(StandardError)
    expect { @robot.place(1, 'pqr', nil) }.to raise_error(StandardError)
  end

  #movement
  #postive moments
  it 'move on the board' do
  #case 1
    @robot.place(1, 2, "east")
    @robot.move
    @robot.move
    @robot.rotate_left
    @robot.move

    expect( @robot.position[:x]).to eq(3)
    expect( @robot.position[:y]).to eq(3)
    expect( @robot.direction).to eq("north")
  #case2
    @robot.place(1, 1, "east")
    expect( @robot.move).to eq("moved")
    expect( @robot.position[:x]).to eq(2)
    expect( @robot.position[:y]).to eq(1)
    expect( @robot.direction).to eq("east")
  end

  #negtive
  it 'move on the board' do
  #case 1
    @robot.place(1, 2, "east")
    @robot.move
    @robot.move
    @robot.rotate_left
    @robot.move
    expect( @robot.position[:x]).to eq(3)
    expect( @robot.position[:y]).to eq(3)
    expect( @robot.direction).to_not eq("south")
  #case2
    @robot.place(1, 1, "east")
    expect( @robot.move).to eq("moved")
    expect( @robot.position[:x]).to eq(2)
    expect( @robot.position[:y]).to eq(1)
    expect( @robot.direction).to_not eq("north")
  end

  #right rotation
  it 'should rotate on its right' do
   @robot.place(0, 0, "north")
   @robot.rotate_right
   expect( @robot.direction).to eq("east")
  end

  #left rotation
  it 'should rotate on its left' do
     @robot.place(0, 0, "north")
     @robot.rotate_left
     expect( @robot.direction).to eq("west")
     @robot.rotate_left
     expect( @robot.direction).to_not eq("west")
  end

  #reporting of robot
  it 'should report its position' do
    @robot.place(5, 5, "east")
    expect( @robot.report).to eq("The bot is on 5,5 facing towards east")
    @robot.move
    expect( @robot.report).to eq("The bot is on 5,5 facing towards east")
    @robot.rotate_right
    @robot.move
    expect( @robot.report).to eq("The bot is on 5,4 facing towards south")
  end

end
