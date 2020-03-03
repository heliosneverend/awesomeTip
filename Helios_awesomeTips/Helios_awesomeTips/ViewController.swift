//
//  ViewController.swift
//  Helios_awesomeTips
//
//  Created by helios on 2020/2/21.
//  Copyright © 2020 helios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
        testListNode()
       
    }
    private func testListNode() {
        let one = ListNode(1)
        let two = ListNode(5)
        let three = ListNode(3)
        let four = ListNode(2)
        let five = ListNode(4)
        let six = ListNode(2)
        one.next = two
        two.next = three
        three.next = four
        four.next = five
        five.next = six
        let result = self.partition(one, 3)
        var dummy = result
        while dummy != nil {
            print("node val: \(String(describing: dummy?.val))")
            dummy = dummy?.next
        }
    }
    //链表给出一个链表和一个值x，要求将链表中所有小于x的值放到左边，所有大于x的值放到右边，并且原链表的节点顺序不能变
   
    func partition(_ head : ListNode?, _ x : Int)->ListNode? {
        let prevDummy: ListNode = ListNode(0), postDummy = ListNode(0)
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
    //给出一个整数数组和一个目标值，判断数组中是否有两个数之和等于目标值
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
    // 给定一个整型数组中有且仅有两个数之和等于目标值，求这两个数在数组中的序号
    // 为了获得序号使用字典
    private func twoSumReturnNum(array: [Int], target: Int) -> [Int] {
        var dic = [Int : Int]()
        for (i, num) in array.enumerated() {
            if let temp = dic[target - num] {
                return [temp, i]
            } else {
                dic[num] = i
            }
        }
        fatalError("no valid output")
    }
    // 各位相加 给定一个非负整数 num，反复将各个位上的数字相加，直到结果为一位数。
    /*
     输入: 178
     输出: 7
     解释: 各位相加的过程为：1 + 7 + 8 = 16, 1 + 6 = 7。 由于 7 是一位数，所以返回
     */
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
    /*
     给定两个大小为 m 和 n 的有序数组 nums1 和 nums2。
     请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。
     */
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
}
class ListNode {
    var val: Int!
    var next: ListNode!
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
class List {
    var head: ListNode?
    var tail: ListNode?
    // 尾插法
    func appendFromTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail?.next = ListNode(val)
            head = tail?.next
        }
    }
    //头插法
    func appendFromHead(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let temp = ListNode(val)
            tail?.next = head
            head?.next = temp
        }
    }
}
