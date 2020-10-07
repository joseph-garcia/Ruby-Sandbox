class Node
    attr_accessor :root, :left, :right
    
    def initialize(root)
        @root = root
    end

end

class Tree
    @parentNode
    #traverse left inits parent node
    attr_accessor :root

    def initialize(array)
        @array = array
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
            puts node_to_add
            puts rootNode.root
            puts "Duplicate value. No new node added."
        end

        return rootNode

    end

    def getChildStatus(rootNode)
        if rootNode.left.nil? && rootNode.right.nil?
            return "No children"
        elsif (!rootNode.left.nil? && !rootNode.right.nil?)
            return "Two children"
        else
            return "One child"
        end
        puts "Error in getChildStatus"
    end

    def traverseLeft(root_node)
        @parentNode = root_node
        if !root_node.left.nil?
            traverseLeft(root_node.left)
        else
            return root_node
        end
    end

    def switchNodes(old_node, new_node)
        temp = old_node
        old_node = new_node
        new_node = temp
    end

    def delete_node(node_to_delete, rootNode)
        # look for node to delete
        if node_to_delete != rootNode.root
            @parentNode = rootNode
            if node_to_delete > rootNode.root
                delete_node(node_to_delete, rootNode.right)
            elsif node_to_delete < rootNode.root
                delete_node(node_to_delete, rootNode.left)
            end
        end

        # 3 cases of deletion:
        #1. Delete a leaf if it has no children
        def deleteNodeNoChild(node_to_delete)
            # delete parent reference
            if @parentNode.right == node_to_delete
                @parentNode.right = nil
            elsif @parentNode.left == node_to_delete
                @parentNode.left = nil
            end
            return
        end

        #2. Delete a leaf if it has one child
        def deleteOneChild(node_to_delete)
            # Get a reference to node marked for deletion
            if @parentNode.right == node_to_delete
                upperNode = @parentNode.right
            elsif @parentNode.left == node_to_delete
                upperNode = @parentNode.left
            end

            # Get a reference to replacement node
            lowerNode = upperNode.right.nil? ? upperNode.left : upperNode.right

            #Switch values & unhook old node
            if upperNode.right == lowerNode
                tmp = lowerNode
                upperNode.right = nil
                upperNode.root = tmp.root
                upperNode = tmp
            elsif upperNode.left == lowerNode
                tmp = lowerNode
                upperNode.left = nil
                upperNode.root = tmp.root
                upperNode = tmp
            else
                puts "Error in deleteOneChild"
            end

            return
        end

        if node_to_delete == rootNode.root && getChildStatus(rootNode) == "No children"            
            return deleteNodeNoChild(rootNode)
        end

        # delete a node w/ one child - have child take over parent
        if node_to_delete == rootNode.root && getChildStatus(rootNode) == "One child"
            return deleteOneChild(rootNode)        
        end

        # delete a node w/ 2 children - find the next highest # by
        # visiting the left-most child of the right-child
        if node_to_delete == rootNode.root && getChildStatus(rootNode) == "Two children"
            #puts "Parent node is #{@parentNode.inspect}"
            # go down one right-subtree
            rightTreeNode = rootNode.right
            # go to the furthest left you can go
            leftMostNode = traverseLeft(rightTreeNode)
            # if the left-most leaf has no right child, switch leaf with rootNode
            # then delete leaf
            if leftMostNode.right.nil?
                rootNode.root = leftMostNode.root

                deleteNodeNoChild(leftMostNode, @parentNode)
                puts rootNode.inspect
                puts
                puts leftMostNode.inspect
            else
                #switch leaf with rootNode
                rootNode.root = leftMostNode.root
                #delete rootNode with deleteOneChild
                deleteOneChild(leftMostNode, @parentNode)
            end
            return rootNode
        end


    end

end

def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.root}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

# sort unsorted array
initialArray = [2,6,14,12,18,20,24,36,48,52,70,5,8,44,1,3,99,4,25,31,26]
sortedArray = initialArray.sort.uniq

# create BST from sorted array
bsTree = Tree.new(sortedArray)
bsTree.create_tree(sortedArray, 0, sortedArray.length-1)

# insert node
bsTree.insert_node(13, bsTree.root)

#delete node test
bsTree.delete_node(26, bsTree.root)


# print tree
pretty_print(bsTree.root)