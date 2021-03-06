class Node
	attr_reader :value
	attr_accessor :left_child, :right_child

	def initialize(value=nil)
		@value = value;
		left_child = nil;
		right_child = nil;
	end

end


class BinarySearchTree

	def initialize(root = nil)
		@root = root
	end

	def set_root(root_value)
		@root = Node.new(root_value)
		puts "Our Binary Search Tree's root is set to " + @root.value.to_s
	end

	def tree_queue(array)
		set_root(array.shift)
		array.shuffle.each do |num|
			insert(num)
		end
	end

# commented out the put statements in this method, but if you make them active it will print to the terminal
# so that you can see how the tree is being built.
	def insert(value)
		puts "inserting: " + value.to_s
		current_node = @root
		#puts "We are at the root node : " + current_node.value.to_s
		while nil != current_node
				if (value < current_node.value) && (current_node.left_child == nil)
					current_node.left_child = Node.new(value)
					#puts value.to_s + " has been made left child of " + current_node.left_child.parent_node.value.to_s
				elsif (value > current_node.value) && (current_node.right_child == nil)
					current_node.right_child = Node.new(value)
					#puts value.to_s + " has been made right child of " + current_node.right_child.parent_node.value.to_s
				elsif (value < current_node.value)
					current_node = current_node.left_child
					#puts "current_node is " + current_node.value.to_s
				elsif (value > current_node.value)
					current_node = current_node.right_child
					#puts "current_node is " + current_node.value.to_s
				else
					return
				end
		end
	end

	def breadth_first_search(target)
		queue = [@root]

		until queue.empty? do
			current_node = queue.shift
				return current_node.value.to_s if current_node.value == target
				queue << current_node.left_child unless current_node.left_child.nil?
				queue << current_node.right_child unless current_node.right_child.nil?
		end
		nil
	end

	def depth_first_search(target, current_node = @root)
		stack = []
		loop do
				if current_node != nil
					stack << current_node
					current_node = current_node.left_child
				else
					return nil if stack.empty?
					current_node = stack.pop
					return current_node.value if current_node.value == target
					current_node = current_node.right_child
				end
		end
	end

	def dfs_recursive(target, current_node = @root)
		puts current_node.value.to_s if current_node.value == target
		leaf = dfs_recursive(target, current_node.left_child) if current_node.left_child != nil
		return leaf unless leaf.nil?
		leaf = dfs_recursive(target, current_node.right_child) if current_node.right_child != nil
		return leaf unless leaf.nil?
		nil
	end


end

run = BinarySearchTree.new
run.tree_queue((numbers = 20.times.map{rand(500)}))
#run.breadth_first_search(4)
#run.depth_first_search(7)
#run.dfs_recursive(99)
