require_relative 'lib/tree'

array = (Array.new(15) { rand(1..100) })
test = Tree.new(array)
puts test.balanced?
test.level_order_recursive
test.level_order
test.preorder
test.preorder_recursive
test.inorder
# Dodać post order
test.pretty_print
test.insert(104)
test.insert(107)
test.insert(106)
test.insert(1_235_446)
test.pretty_print
puts test.balanced?
test.rebalance
puts test.balanced?
test.pretty_print

p test.postorder
