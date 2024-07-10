require_relative 'lib/tree'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test = Tree.new(array)
# test.pretty_print
# test.delete(324)
test.delete(4)
test.delete(5)
test.delete(67)
test.delete(1)
test.delete(8)
test.insert(6000)
test.insert(55)
test.insert(55)
test.insert(56)
test.insert(234)
test.insert(235)
test.insert(238)
test.insert(666)
test.insert(4565)
test.insert(4564)
test.delete(55)
# test.insert(54)
test.insert(55)
test.insert(52)
test.insert(51)
test.insert(50)
test.insert(239)
test.insert(8)
test.pretty_print
# p test.find(55)
# p test.find(54)
# p test.size

# test.preorder_recursive { |e| puts "this is preorder #{e.data} recursive" }
# p test.preorder_recursive

# test.preorder { |e| puts "this is preorder #{e.data} iteration" }
# p test.preorder

test.inorder { |e| puts "this is inorder #{e.data} recursive" }
p test.inorder

# test.level_order { |e| puts "this is level order #{e.data} iteration" }
# p test.level_order

# test.level_order_recursive { |e| puts "this is level order #{e.data} recursive" }
# p test.level_order_recursive

# p test.height(9)
# p test.depth(4564)
# p test.height(56)
# p test.depth(56)

# test.postorder_recursive { |e| puts "this is postorder #{e.data} recursive" }
# p test.postorder_recursive

# test.postorder { |e| puts "this is postorder #{e.data} recursive" }
# p test.postorder
# p test.balanced?
# test.rebalance
# p test.balanced?
