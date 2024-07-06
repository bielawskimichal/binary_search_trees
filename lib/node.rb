class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def has_children?
    return false if @left.nil? || @right.nil?

    true
  end

  def has_right?
    return false if @right.nil?

    true
  end

  def has_left?
    return false if @left.nil?

    true
  end
end
