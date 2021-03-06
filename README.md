# awesomeTip
## 时间复杂度
O(1)常数
O(n)
O(n^2)
O(logn) 对数阶时间复杂度
```
func logn(n) {
    let i = 1;
    while(i < n) {
        i = i * 2
    }
    return i
}
```
是log2n 以2为底n的对数 底数可变就是logn
O(n*logn)

## 给出一个整数数组和一个目标值，判断数组中是否有两个数之和等于目标值
利用集合,遍历数组用集合每次保存当前值 假如集合中已经有一个数等于目标值减去当前值 则证明之前的遍历一定有一个数与当前值之和等于目标值 时间复杂度 O(n)
```
    private func twoSum(array: [Int], target: Int) -> Bool {
        var set = Set<Int>()
        for num in array {
            if set.contains(target - num) {
                return true
            }
            set.insert(num)
        }
        return false
    }
```
## 给定一个整型数组中有且仅有两个数之和等于目标值，求这两个数在数组中的序号 为了获得序号使用字典
```
    private func twoSumReturnNum(array: [Int], target: Int) -> [Int] {
        var dic = [Int : Int]()
        for (i, num) in array.enumerated() {
            if let temp = dic[target - num] {
                return [temp, i]
            } else 
                dic[num] = i
            }
        }
        fatalError("no valid output")
    }

```
## 各位相加 给定一个非负整数 num，反复将各个位上的数字相加，直到结果为一位数
## 输入: 178 
## 输出: 7
## 解释: 各位相加的过程为：1 + 7 + 8 = 16, 1 + 6 = 7。 由于 7 是一位数，所以返回
```
    private func addDigits(_ num: Int) -> Int {
        var result = 0
        var num = num
        while true {
            while num > 0 {
                let digits = num % 10
                result += digits
                num = num / 10
            }
            if result < 10 {
                return result
            } else {
                num = result
                result = 0
            }
        }
    }
```
##   给定两个大小为 m 和 n 的有序数组 nums1 和 nums2。 请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。
```
    private func findMedianSortedArray(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var allArr: NSMutableArray = NSMutableArray(array: nums1)
        allArr.addObjects(from: nums2)
        allArr.sort { (obj1, obj2) -> ComparisonResult in
            let num1: Int = obj1 as! Int
            let num2: Int = obj2 as! Int
            if num1 > num2 {
                return .orderedDescending
            } else {
                return .orderedAscending
            }
        }
        if ((allArr.count-1)%2) == 0{
            return allArr[(allArr.count-1)/2] as! Double
        } else {
            let flag = (allArr.count-1)/2
            return Double((allArr[flag] as! Int)+(allArr[flag+1] as! Int))/2
        }
    }
```
## 给出一个链表和一个值x，要求将链表中所有小于x的值放到左边，所有大于x的值放到右边，并且原链表的节点顺序不能变 例如：1->5->3->2->4->2，给定 x=3 ，则返回为 1->2->2->5->3->4
```
    func partition(_ head : ListNode?, _ x : Int)->ListNode? {
        let prevDummy : ListNode = ListNode(0), postDummy = ListNode(0)
        var prev = prevDummy, post = postDummy
            
        var node = head
            
        while node != nil {
            if node!.val < x {
                prev.next = node
                prev = node!
            } else {
                post.next = node
                post = node!
            }
            node = node!.next
        }
        //防止构成环
        post.next = nil
        //拼接左右链表
        prev.next = postDummy.next
        return prevDummy.next
    }
```
### 树的基础实现以及广度优先遍历
#### 基础实现
```
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
```
#### 二叉树遍历
```
    
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
```
树的相关 demo
