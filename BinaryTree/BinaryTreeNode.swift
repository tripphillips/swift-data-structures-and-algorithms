//
//  BinaryTreeNode.swift
//  BinaryTree
//
//  Created by Trip Phillips on 5/5/22.
//

import Foundation

public class BinaryTreeNode<T> {
    
    public var value: T
    public var leftChild: BinaryTreeNode?
    public var rightChild: BinaryTreeNode?
    
    public init(value: T) {
        self.value = value
    }
    
}

extension BinaryTreeNode: CustomStringConvertible {

  public var description: String {
    diagram(for: self)
  }

  private func diagram(for node: BinaryTreeNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil && node.rightChild == nil {
      return root + "\(node.value)\n"
    }
    return diagram(for: node.rightChild,
                   top + " ", top + "┌──", top + "│ ")
         + root + "\(node.value)\n"
         + diagram(for: node.leftChild,
                   bottom + "│ ", bottom + "└──", bottom + " ")
  }
}

// MARK: - Traversals
extension BinaryTreeNode {
    
    public func inorderTraversal(visit: (T) -> Void) {
        leftChild?.inorderTraversal(visit: visit)
        visit(value)
        rightChild?.inorderTraversal(visit: visit)
    }
    
    public func preorderTraversal(visit: (T) -> Void) {
        visit(value)
        leftChild?.preorderTraversal(visit: visit)
        rightChild?.preorderTraversal(visit: visit)
    }
    
    public func postorderTraversal(visit: (T) -> Void) {
        leftChild?.postorderTraversal(visit: visit)
        rightChild?.postorderTraversal(visit: visit)
        visit(value)
    }
    
    // For Challenge 2 - Serialization
    public func preorderTraversalWithNil(visit: (T?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.preorderTraversalWithNil(visit: visit)
        } else {
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.preorderTraversalWithNil(visit: visit)
        } else {
            visit(nil)
        }
    }
    
}
