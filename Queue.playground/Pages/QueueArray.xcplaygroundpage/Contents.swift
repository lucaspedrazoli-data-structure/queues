// Copyright (c) 2019 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() { }

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var peek: T? {
        return array.first
    }

    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }

    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}

extension QueueArray {
    func reversed() -> QueueArray {
        var queue = self
        var reversed: [T] = []
        var array = queue.array
        while !array.isEmpty {
            if let element = array.popLast() {
                reversed.append(element)
            }
        }
        queue.array = reversed
        return queue
    }
}

//example
var queue = QueueArray<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
print("original: \(queue)")
print("reversed: \(queue.reversed())")
