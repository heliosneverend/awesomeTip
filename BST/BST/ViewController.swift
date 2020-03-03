//
//  ViewController.swift
//  BST
//
//  Created by helios on 2020/3/2.
//  Copyright © 2020 helios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let items: Array<String> = ["A", "B", "D", "", "", "E", "", "", "C", "","F", "", ""]
                let generalBinaryTree: Tree = Tree(items)
                
                //二叉树的遍历
        generalBinaryTree.preorderTraversal(generalBinaryTree.root)
        generalBinaryTree.inorderTraversal(generalBinaryTree.root)
        generalBinaryTree.postOrderTraversal(generalBinaryTree.root)
        generalBinaryTree.levelOrder(generalBinaryTree.root)
        
    }
    

}

class TreeNode {
    var val: String
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: String) {
        self.val = val
    }
}
class Tree {
    var root: TreeNode?
    var items: Array<String>
    var index = -1
    init(_ items: Array<String>) {
        self.items = items
        self.root = self.createTree()
    }
    
    func createTree() -> TreeNode? {
        index = index + 1
        if index >= 0 && index < items.count {
            let item = self.items[index]
            let root = TreeNode(item)
            root.left = createTree()
            root.right = createTree()
            return root
        }
        return nil
    }
    
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        return max(maxDepth(root.left), maxDepth(root.right)) + 1
    }
    
    // 是否为二分查找树
    func isValidBST(_ root: TreeNode?) -> Bool {
        return CheckBSTNode(root, min: nil, max: nil)
    }
    
    func CheckBSTNode(_ node: TreeNode?, min: String? , max: String?) -> Bool {
        guard let node = node else { return true }
        if let min = min, node.val <= min {
            return false
        }
        if let max = max, node.val >= max {
            return false
        }
        return CheckBSTNode(node.left, min: min, max: node.val) && CheckBSTNode(node.right, min: node.val, max: max)
    }
    
    //二叉树遍历 前序、中序、后序遍历，以及层次遍历即广度优先遍历
    //前序遍历 preorderTraversal.png 根节点->左子树->右子树
    func preorderTraversal(_ root: TreeNode?) {
        guard let root = root else {
            print("空", separator: "", terminator: " ")
            return
        }
        print(root.val, separator: "", terminator: " ")
        preorderTraversal(root.left)
        preorderTraversal(root.right)
    }
    
    //用栈实现前序遍历
    func preorderWithStackTraversal(_ root: TreeNode?) {
        var res = [String]()
        var stack = [TreeNode]()
        let temp = TreeNode("test")
        var node = root
        while !stack.isEmpty || node != nil {
            if node != nil {
                res.append(node?.val ?? "")
                stack.append(node ?? temp)
                node = node?.left
            } else {
                node = stack.removeLast().right
            }
        }
        print(res)
    }
    //中序遍历 左子树->根节点->右子树
    func inorderTraversal(_ root: TreeNode?) {
        guard let root = root else {
            print("空", separator: "", terminator: " ")
            return
        }
        inorderTraversal(root.left)
        print(root.val, separator: "", terminator: " ")
        inorderTraversal(root.right)
    }
    //后续遍历 左子树->右子树->根节点
    func postOrderTraversal(_ root: TreeNode?) {
        guard let root = root else {
            print("空", separator: "", terminator: " ")
            return
        }
        postOrderTraversal(root.left)
        postOrderTraversal(root.right)
        print(root.val, separator: "", terminator: " ")
    }
    //层级遍历 广度优先
    func levelOrder(_ root: TreeNode?) {
        var res = [[String]]()
        //用数组实现队列
        var queue = [TreeNode]()
        if let root = root {
            queue.append(root)
        }
        while queue.count > 0 {
            let size = queue.count
            var level = [String]()
            for _ in 0..<size {
                let node = queue.removeFirst()
                level.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(level)
        }
        print("res \(res)")
    }
}

class BinaryTreeNode { //针对中序遍历
    var val: String
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    // true 指向左子树 false指向前驱
    var leftTag: Bool = true
    // true 指向右子树 false指向前驱
    var rightTag: Bool = true
    init(_ val: String) {
        self.val = val
    }
}
class BinaryTree {
    var root: BinaryTreeNode?
    var items: Array<String>
    var index = -1
    var preNode: BinaryTreeNode?
    var headNode: BinaryTreeNode?
    init(_ items: Array<String>) {
        self.items = items
        self.root = self.createTree()
        self.headNode = BinaryTreeNode("")
        self.headNode?.left = self.root
        self.headNode?.leftTag = true
        self.preNode = headNode
    }
    //以前序二叉树创建二叉树
    func createTree() -> BinaryTreeNode? {
        self.index = self.index+1
            if index < self.items.count && index >= 0{
                let item = self.items[index]
                if item == "" {
                    return nil
                } else {
                    let root = BinaryTreeNode(item)
                    root.left = createTree()
                    root.right = createTree()
                    return root
                }
            }
        return nil
    }
    // 前序遍历
    func preorderTraversal(_ root: BinaryTreeNode?) {
        //遍历根节点
        guard let root = root else {return}
        print(root.val, separator: "", terminator: " ")
        if root.leftTag {
            preorderTraversal(root.left)
        } else if root.rightTag {
            preorderTraversal(root.right)
        }
    }
    // 中序遍历
    func inorderTeaversal(_ root: BinaryTreeNode?) {
        if root != nil {
            inorderTeaversal(root?.left)
            //如果节点的左节点为nil，那么将该节点指向中序遍历的前驱
            if root?.left == nil {
                root?.leftTag = false
                root?.left = preNode
            }
            if preNode?.right == nil {
                preNode?.rightTag = false
                preNode?.right = root
            }
            preNode = root
            inorderTeaversal(root?.right)
        }
    }
}

