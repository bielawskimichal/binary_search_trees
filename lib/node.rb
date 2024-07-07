class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def has_children?
    has_right_child? || has_left_child?
  end

  def has_both_children?
    has_right_child? && has_left_child?
  end

  def has_no_children?
    !has_children?
  end

  def has_right_child?
    return false if @right.nil?

    true
  end

  def has_left_child?
    return false if @left.nil?

    true
  end

  def has_right_child_only?
    has_right_child? && !has_left_child?
  end

  def has_left_child_only?
    has_left_child? && !has_right_child?
  end
end
