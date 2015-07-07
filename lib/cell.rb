class Cell
  attr_accessor :alive

  def initialize(alive)
    @alive = alive
  end

  def to_s
    alive? ? " - " : "   "
  end

  def kill
    @alive = false
  end

  def live
    @alive = true
  end

  def alive?
    alive
  end
end
