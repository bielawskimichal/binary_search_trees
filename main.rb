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
test.insert(4565)
test.insert(54)
test.delete(55)
test.pretty_print
p test.find(55)
p test.find(54)

test.inorder { |e| puts "this is inorder #{e.data} recursive" }

p test.inorder

test.level_order { |e| puts "this is level order #{e.data} iteration" }
p test.level_order

test.level_order_rec { |e| puts "this is level order #{e.data} recursive" }
p test.level_order_rec
