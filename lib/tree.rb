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

  def size(it = 0, node = @root, &block)
    return it if node.nil?

    it += 1

    it = size(it, node.left)
    it = size(it, node.right)
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
        tmp.right = current_node.right if dir == 1
        tmp.left = current_node.right if dir == 0
        current_node = nil
      elsif current_node.has_left_child_only?
        tmp.right = current_node.left if dir == 1
        tmp.left = current_node.left if dir == 0
        current_node = nil
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

  def balanced?
    (-1..1).include?(height(@root.left.data) - height(@root.right.data))
  end

  def rebalance
    return if balanced?

    array = inorder
    @root = build_tree(array, 0, array.length - 1)
  end

  def inorder(node = @root, result = [], &block)
    return result if node.nil? && !result.empty?
    return nil if node.nil?

    if block_given?
      inorder(node.left, result, &block)
      yield(node)
      inorder(node.right, result, &block)
    else
      inorder(node.left, result) { |n| result << n.data }
      result << node.data
      inorder(node.right, result) { |n| result << n.data }
    end
  end

  def postorder(node = @root, result = [], &block)
    return result if node.nil? && !result.empty?
    return nil if node.nil?

    if block_given?
      postorder(node.left, result, &block)
      postorder(node.right, result, &block)
      yield(node)
    else
      postorder(node.left, result) { |n| result << n.data }
      postorder(node.right, result) { |n| result << n.data }
      result << node.data
    end
  end

  def preorder
    return [] if @root.nil?

    queue = [@root]
    result = []

    until queue.empty?
      node = queue.shift

      block_given? ? yield(node) : result << node.data

      queue.insert(0, node.left) if node.left
      queue.insert(0, node.right) if !node.left && node.right
      queue.insert(1, node.right) if node.left && node.right
    end

    result unless result.empty?
  end

  def preorder_recursive(node = @root, result = [], &block)
    return [] if @root.nil?
    return result if node.nil? && !result.empty?
    return if node.nil?

    if block_given?
      yield(node)
      preorder_recursive(node.left, result, &block) if block_given?
      preorder_recursive(node.right, result, &block) if block_given?
    else
      result << node.data
      preorder_recursive(node.left, result) { |n| result << n.data }
      preorder_recursive(node.right, result) { |n| result << n.data }
    end
  end

  def level_order_recursive(queue = [@root], result = [], &block)
    return [] if @root.nil?
    return result if queue.empty? && !result.empty?
    return if queue.empty?

    node = queue.shift

    block_given? ? yield(node) : result << node.data

    queue << node.left if node.left
    queue << node.right if node.right

    level_order_recursive(queue, result, &block)
  end

  def level_order
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

  def height(node, it = 0)
    node = find(node)
    return it if node.nil?

    it += 1

    if node.has_both_children? && size(0, node.left) > size(0, node.right)
      it = height(node.left.data, it)
    elsif node.right
      it = height(node.right.data, it)
    elsif node.left
      it = height(node.left.data, it)
    end
    it
  end

  def depth(node, current = @root, it = 0)
    return nil if find(node).nil?

    it += 1
    return it if node == current.data

    node < current.data ? depth(node, current.left, it) : depth(node, current.right, it)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
