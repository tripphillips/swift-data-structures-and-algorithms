//
//  RingBuffer.swift
//  Queue
//
//  Created by Trip Phillips on 5/1/22.
//

import Foundation
/**
 Fixed-length ring buffer
 In this implementation, the read and write pointers always increment and
 never wrap around. On a 64-bit platform that should not get you into trouble
 any time soon.
 Not thread-safe, so don't read and write from different threads at the same
 time!
 */
public struct RingBuffer<T> {
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }
    
    /// Returns false if out of space.
    @discardableResult
    public mutating func write(_ element: T) -> Bool {
        guard !isFull else { return false }
        defer {
            writeIndex += 1
        }
        array[wrapped: writeIndex] = element
        return true
    }
    
    /// Returns nil if the buffer is empty.
    public mutating func read() -> T? {
        guard !isEmpty else { return nil }
        defer {
            array[wrapped: readIndex] = nil
            readIndex += 1
        }
        return array[wrapped: readIndex]
    }

    public var first: T? {
        array[wrapped: readIndex]
    }
    
    public var isEmpty: Bool {
        return availableSpaceForReading == 0
    }
    
    public var isFull: Bool {
        return availableSpaceForWriting == 0
    }
    
    private var availableSpaceForReading: Int {
        return writeIndex - readIndex
    }
    
    private var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
    }
}

extension RingBuffer: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var index = readIndex
        return AnyIterator {
            guard index < self.writeIndex else { return nil }
            defer {
                index += 1
            }
            return self.array[wrapped: index]
        }
    }
}

private extension Array {
    subscript (wrapped index: Int) -> Element {
        get {
            return self[index % count]
        }
        set {
            self[index % count] = newValue
        }
    }
}

extension RingBuffer: CustomStringConvertible {
  public var description: String {
    let values = (0..<availableSpaceForReading).map {
      String(describing: array[($0 + readIndex) % array.count]!)
    }
    return "[" + values.joined(separator: ", ") + "]"
  }
}
