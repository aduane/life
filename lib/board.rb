class Board
  require_relative 'cell'
  attr_accessor :hlimit, :vlimit, :playfield, :scratchpad

  def initialize(size)
    @hlimit = size - 1
    @vlimit = size - 1
    @playfield = []

    0.upto(hlimit) do |x|
      playfield[x] = []
      0.upto(vlimit) do |y|
        playfield[x] << Cell.new([true, false].sample)
      end
    end
  end

  def display
    0.upto(hlimit) do |x|
      0.upto(vlimit) do |y|
        print playfield[x][y]
      end
      print "\n"
    end
  end

  def act
    scratchpad = Marshal.load(Marshal.dump(self)) #deep copy
    0.upto(hlimit) do |x|
      0.upto(vlimit) do |y|
        scratchpad.decide(x,y) ? playfield[x][y].live : playfield[x][y].kill
      end
    end
  end
  
  def decide(x_cord, y_cord)
    neighbors = []

    transforms = [
      [-1,-1],  [0,-1], [1,-1],
      [-1,0],   [0, 0], [1,0],
      [-1,1],   [0,1],  [1,1]
    ]

    transforms.each do |x,y|
      next if x == 0 && y == 0
      next if ((x_cord + x) < 0) || ((x_cord + x) > hlimit)
      next if ((y_cord + y) < 0) || ((y_cord + y) > vlimit)
      neighbors << playfield[x_cord + x][y_cord + y]
    end

    alive_neighbors = neighbors.select(&:alive?)

    if playfield[x_cord][y_cord].alive?
      case alive_neighbors.count
      when 0..1
        false
      when 2..3
        true
      when 4..8
        false
      else
        raise "There should never be that many neighbors"
      end
    else
      (alive_neighbors.count == 3) ? true : false
    end
  end
end
