//
//  File.swift
//  
//
//  Created by Caleb Wilson on 17/03/2021.
//

import Foundation

public class LinkedListNode<T: Comparable> {
    public var value : T
    public var next : LinkedListNode<T>?
    
    public init(value : T) {
        self.value = value
    }
    
    public func returnLinks(theNode : LinkedListNode,currString : String) -> String {
        if let nextNode = theNode.next {
            return (currString  + ("\(theNode.value)") + " -> " + returnLinks(theNode: nextNode, currString: currString))
        }
        return "\(theNode.value)"
    }
}

public class LinkedList<T: Comparable> {
    public var head : LinkedListNode<T>?
    public var tail : LinkedListNode<T>?
    public var size = 0
    
    public var isEmpty : Bool {
        head == nil
    }
    
    public var first: LinkedListNode<T>? {
        head
    }
    
    public var last : LinkedListNode<T>? {
        tail
    }
    
    public init(from list : [T]? = nil, makeSorted : Bool? = nil) {
        
        guard let listOfValues = list else {
            return
        }
        
        size = listOfValues.count
        for item in listOfValues {
            if makeSorted ?? false {
                self.appendWhenSortedList(value: item)
            } else {
                self.append(value: item)
            }
        }
    }
    
    public func append(value : T){
        let newNode = LinkedListNode(value: value)
        
        if head == nil {
            self.head = newNode
        } else {
            if tail != nil {
                tail!.next = newNode
            }
        }
        self.tail = newNode
        size += 1
    }
    
    public func appendWhenSortedList(value : T) {
        let newNode = LinkedListNode(value: value)
        var node = head
        
        
        if (size == 0){
            head = newNode
            tail = newNode
            size += 1
            return
        }
        
        if (value < node!.value) {
            newNode.next = node
            head = newNode
            size += 1
            return
        }
        
    
        while (node!.next != nil) {
            if node!.next!.value > value {
                newNode.next = node!.next
                node!.next = newNode
                size += 1
            }
            node = node!.next
        }
        
        tail!.next = newNode
        tail = newNode
        size += 1
        
        
    }
    
    public func printMyList(){
        if head != nil {
            print(head!.returnLinks(theNode: head!, currString: ""))
        }
    }
    
    public func doesContain(this : T) -> Bool{
        var node = head
        
        while node != nil {
            if node?.value == this {
                return true
            }
            node = node?.next
        }
        
        return false
    }
    
    public func get(at index : Int) -> LinkedListNode<T>? {
        if index >= 0 {
            var node = head
            var i = index
            
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        
        return nil
    }
    
    public func remove(val : T) {
        var node = head
        var removed = false
        
        while (node != nil && !removed) {
            if (node!.next?.value == val){
                node!.next = node!.next!.next
                size -= 1
                removed = true
            } else {
                node = node?.next
            }
        }
    }
    
    public func remove(at index : Int){
        if index > 0 {
            var node = head
            var i = index
            
            while (node != nil){
                if (i == 1){
                    node!.next = node!.next?.next
                    size -= 1
                    return
                }
                node = node!.next
                i -= 1
            }
        }
        
        if (index == 0) {
            size -= 1
            self.head = self.head?.next
        }
    }
    
    public func insert(value : T,at index : Int){ //if index is too large then its just appended
        if index > 0 {
            var i = index
            var node = head
            var prev : LinkedListNode<T>? = nil
            while (node != nil) {
                if (i == 0){
                    let tempNode = LinkedListNode(value: value)
                    tempNode.next = node
                    prev?.next = tempNode
                    size += 1
                    return
                }
                prev = node
                node = node!.next
                i -= 1
            }
            
            self.append(value: value)
            size += 1
        }
        
        if (index == 0) {
            let tempNode = LinkedListNode(value: value)
            tempNode.next = head
            
            self.head = tempNode
        }
    }
    
    public func reverse() {
        var prev = head // 1 -> 2
        head = head?.next // 2 -> 3 -> 4
        var curNode = head // 2 -> 3 -> 4
        prev?.next = nil // 1 -> nil
        
        while (head != nil){
            head = head?.next //3 -> 4  // 4 -> nil / /nil
            curNode?.next = prev //2 -> 1 -> nil // 3 -> 2 -> 1 -> nil // 4 -> 3 -> 2 -> 1 -> nil
            prev = curNode //2 -> 1 -> nil // 3 -> 2 -> 1 -> nil // 4 -> 3 -> 2 -> 1 -> nil
            curNode = head //3 -> 4 //4 -> nil // nil
        }
        head = prev // 4 -> 3 -> 2 -> 1 -> nil
        
    }
    
    public func replaceAnyInstance(of replacing : T,with new : T){
        var node = head
        
        while (node != nil){
            if (node!.value == replacing){
                node!.value = new
            }
            
            node = node?.next
        }
    }
    
    public func getFirstIndex(of val : T) -> Int {
        var currNode = head
        var currIndex = 0
        
        while (currNode != nil){
            if (currNode?.value == val){
                return currIndex
            } else {
                currIndex += 1
                currNode = currNode?.next
            }
        }
        
        return -1
    }
    
}
