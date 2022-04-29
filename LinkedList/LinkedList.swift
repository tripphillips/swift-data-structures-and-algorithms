//
//  LinkedList.swift
//  LinkedList
//
//  Created by Trip Phillips on 4/27/22.
//

import Foundation

// MARK: - HeadTailLinkedList
public struct LinkedList<T>: HeadTailLinkedList {
    
    public var head: LinkedListNode<T>?
    public var tail: LinkedListNode<T>?
    
    public init() {}
}

// MARK: - HeadTailLinkedListInspectable
extension LinkedList: HeadTailLinkedListInspectable {
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public func node(at index: Int) -> LinkedListNode<T>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
}

// MARK: - HeadTailLinkedListInsertable
extension LinkedList: HeadTailLinkedListInsertable {
    
    public mutating func push(_ value: T) {
        head = LinkedListNode(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: T) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = LinkedListNode(value: value, next: nil)
        tail = tail!.next
    }
    
    @discardableResult
    public mutating func insert(_ value: T,
                                after node: LinkedListNode<T>) -> LinkedListNode<T> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = LinkedListNode(value: value, next: node.next)
        return node.next!
    }
}

// MARK: - HeadTailLinkedListRemovable
extension LinkedList: HeadTailLinkedListRemovable {
    public mutating func pop() -> T? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> T? {
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var previous = head
        var current = head
        
        while let next = current.next {
            previous = current
            current = next
        }
    
        previous.next = nil
        tail = previous
        return current.value
    }
    
    public mutating func remove(after node: LinkedListNode<T>) -> T? {
        defer {
            if node.next === tail {
                tail = node
            }
            
            node.next = node.next?.next
        }
        return node.next?.value
    }
}

extension LinkedList: CustomDebugStringConvertible {

  public var debugDescription: String {
    guard let head = head else {
      return "Empty list"
    }
    return String(describing: head)
  }
}

extension LinkedList: Collection {

    public struct Index: Comparable {

        public var node: LinkedListNode<T>?

        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }

        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }

            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }

    public var startIndex: Index {
        Index(node: head)
    }

    public var endIndex: Index {
        Index(node: tail)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> T {
        position.node!.value
    }
}
