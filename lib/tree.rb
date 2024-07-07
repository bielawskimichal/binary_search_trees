require_relative 'node'
require_relative 'merge_sort'

class Tree
  include Sort

  attr_accessor :root

  def initialize(array)
    array = merge_sort(array.uniq)
    @root = build_tree(array, 0, array.length - 1)
  end

  def build_tree(array, start, finish)
    return nil if start > finish

    mid = (start + finish) / 2

    node = Node.new(array[mid])

    node.left = build_tree(array, start, mid - 1)
    node.right = build_tree(array, mid + 1, finish)

    node
  end

  def find(data, node = @root)
    return nil if node.nil?
    return node if node.data == data

    if data < node.data
      find(data, node.left)
    elsif data > node.data
      find(data, node.right)
    end
  end

  def delete(node, current_node = @root, tmp = nil, dir = nil)
    return node if current_node.nil?

    if node < current_node.data
      delete(node, current_node.left, current_node, 0)
    elsif node > current_node.data
      delete(node, current_node.right, current_node, 1)
    elsif node == current_node.data

      if current_node.has_no_children?
        current_node.data = nil
        dir.zero? ? tmp.left = nil : tmp.right = nil
      elsif current_node.has_right_child_only?
        current_node.data = current_node.right.data
        current_node.right = nil
      elsif current_node.has_left_child_only?
        current_node.data = current_node.left.data
        current_node.left = nil
      else
        c = current_node.right
        loop do
          break unless c.has_left_child?

          c = c.left
        end
        next_close = c.data
        delete(next_close, current_node)
        current_node.data = next_close
      end
    end
  end

  def insert(node, current = @root, previous = nil)
    return @root = Node.new(node) if @root.nil?

    if node < current.data && current.has_left_child?
      insert(node, current.left, current)
    elsif node > current.data && current.has_right_child?
      insert(node, current.right, current)
    elsif node < current.data && !current.has_left_child?
      new_node = Node.new(node)
      current.left = new_node
      new_node
    elsif node > current.data && !current.has_right_child?
      new_node = Node.new(node)
      current.right = new_node
      new_node
    end
  end

  def level_order_recursive(node = @root, &block)
    if block_given?
      yield node
      level_order_recursive(node.left, &block) if node.left
      level_order_recursive(node.right, &block) if node.right
    else
      array = []
      array << node.data
      level_order_recursive(node.left) { |node| array << node.data } if node.left
      level_order_recursive(node.right) { |node| array << node.data } if node.right
      array
    end
  end

  def level_order_iteration
    return [] if @root.nil?

    queue = [@root]
    result = []

    until queue.empty?
      node = queue.shift

      block_given? ? yield(node) : result << node.data

      queue << node.left if node.left
      queue << node.right if node.right
    end

    result unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
