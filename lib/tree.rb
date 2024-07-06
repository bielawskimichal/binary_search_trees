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

  def delete(node, current_node = @root)
    # raise RootError if node == @root.data
    return node if node.nil?

    if node < current_node
      node.left = delete(node, node.left)

      if node.left.data == node
        
      end

      node
    elsif node > current_node
      node.right = delete(node, node.left)
      node
    end

    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
