
# initialize start = 0, end = array.length - 1
# mid = (start + end) / 2
# create a tree node with mid as root (lets call it A)
# recursively do following steps:
# calculate mid of left subarray and make it root of left subtree of A
# calculate mid of right subarray and make it root of right subtree of A

class Node
    attr_accessor :root, :left, :right
    
    def initialize(root)
        @root = root
    end
end

class Tree
    attr_accessor :root
    def initialize(array)
        @array = array
    end

    def getRoot()
        return @root
    end

    # create tree method
    def create_tree(array, start_point, end_point)
        if (start_point > end_point)
            return nil
        end
        
        mid_point = (start_point + end_point) / 2
        root = Node.new(array[mid_point])
        
        root.left = create_tree(array, start_point, mid_point-1)
        root.right = create_tree(array, mid_point+1, end_point)
        
        @root = root
        return @root
    end

    def insert_node(node_to_add, rootNode)
        # start with root node
        if node_to_add > rootNode.root
            if rootNode.right.nil?
                x = Node.new(node_to_add)
                rootNode.right = x
            else
                insert_node(node_to_add, rootNode.right)
            end
        elsif node_to_add < rootNode.root
            if rootNode.left.nil?
                x = Node.new(node_to_add)
                rootNode.left = x
            else
                insert_node(node_to_add, rootNode.left)
            end
        else
            puts "Duplicate value. No new node added."
        end

    end

    def getChildStatus(rootNode)
        if rootNode.left.nil? && rootNode.right.nil?
            return "No children"
        elsif !rootNode.left.nil? && !rootNode.left.nil?
            puts rootNode.inspect
            return "Two children"
        else
            return "One child"
        end
        puts "Error in getChildStatus"
    end

    def delete_node(node_to_delete, rootNode)
        @parentNode
        # 3 cases:
        # delete a leaf if root has no children
        def deleteNoChildren(rootNode)
            rootNode.root = nil
            @parentNode.right = nil
            @parentNode.left = nil
            puts "No children. Deleting"
            return rootNode
        end
        if node_to_delete == rootNode.root && getChildStatus(rootNode) == "No children"            
            return deleteNoChildren(rootNode)
        end

        # delete a node w/ one child - have child take over parent
        if node_to_delete == rootNode.root && getChildStatus(rootNode) == "One child"
            if rootNode.right.nil?
                rootNode = rootNode.left
                rootNode.left = nil
            else
                rootNode = rootNode.right
                rootNode.right = nil
            end
            puts "One child."
            return
        end

        # delete a node w/ 2 children - find the next highest # by
        # visiting the left-most child of the right-child
        if node_to_delete == rootNode.root && getChildStatus(rootNode) == "Two children"
            puts "Two childrenino."
            return
        end
        # switch the left-most leaf with the root node
        # if it isn't a leaf eg has a right child, then switch
        # like normal but have child take over parent like in
        # above function

        # node_to_delete != rootNode, keep looking
        if node_to_delete != rootNode.root
            @parentNode = rootNode
            if node_to_delete > rootNode.root
                delete_node(node_to_delete, rootNode.right)
            elsif node_to_delete < rootNode.root
                delete_node(node_to_delete, rootNode.left)
            end
        end


    end

end

def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.root}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

# sort unsorted array
initialArray = [1,2,3,4,5,10,11,12]
sortedArray = initialArray.sort.uniq

# create BST from sorted array
bsTree = Tree.new(sortedArray)
bsTree.create_tree(sortedArray, 0, sortedArray.length-1)

# insert node
#bsTree.insert_node(11, bsTree.getRoot())

#delete node
#bsTree.delete_node(11, bsTree.getRoot())

bsTree.delete_node(11, bsTree.getRoot())

# print tree
pretty_print(bsTree.getRoot())

puts bsTree.inspect