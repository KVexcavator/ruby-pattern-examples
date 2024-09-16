#Given a binary search tree, rearrange the tree in in-order so that 
#the leftmost node in the tree is now the root of the tree, 
#and every node has no left child and only 1 right child.
#Input: [5,3,6,2,4,null,8,1,null,null,null,7,9]
#Output: [1,null,2,null,3,null,4,null,5,null,6,null,7,null,8,null,9]

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {TreeNode}

def increasing_bst(root)
  stk, out, cur = [], [], root
  while cur || !stk.empty?
    while cur
      stk.push cur
      cur = cur.left
    end
    cur = stk.pop
    out.push cur.val
    cur = cur.right
  end
  out
end
