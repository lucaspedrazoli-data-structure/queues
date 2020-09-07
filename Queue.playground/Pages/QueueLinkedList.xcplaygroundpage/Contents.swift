// Copyright (c) 2019 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public class QueueLinkedList<T>: Queue {
    private var list = DoublyLinkedList<T>()
    public init() { }

    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }

    public func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }

    public var peek: T? {
        list.first?.value
    }

    public var isEmpty: Bool {
        list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        String(describing: list)
    }
}

//example
var queue = QueueLinkedList<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue
queue.dequeue()
queue
queue.peek


public class Node<T> {

  public var value: T
  public var next: Node<T>?
  public var previous: Node<T>?

  public init(value: T) {
    self.value = value
  }
}

extension Node: CustomStringConvertible {

  public var description: String {
    String(describing: value)
  }
}

public class DoubleQueueLinkedList<T>: DoubleEndedQueue {

  private var head: Node<T>?
  private var tail: Node<T>?

  public init() { }

  public var isEmpty: Bool {
    head == nil
  }

  public var first: Node<T>? {
    head
  }

  public var last: Node<T>? {
    tail
  }

  public func peek(from direction: Direction) -> Node<T>? {
    return head
  }

  public func enqueue(_ element: Node<T>, to direction: Direction) -> Bool {
    if direction == .back {
      append(element.value)
    } else {
      prepend(element.value)
    }
    return true
  }

  public func dequeue(from direction: Direction) -> Node<T>? {
    guard let head = head else {
      return nil
    }
    if direction == .front {
      defer { remove(head) }
      return head
    } else {
      defer { remove(tail!) }
      return tail
    }
  }

  public func prepend(_ value: T) {
    let newNode = Node(value: value)
    guard let headNode = head else {
      head = newNode
      tail = newNode
      return
    }

    newNode.previous = nil
    newNode.next = headNode
    headNode.previous = newNode

    head = newNode
  }

  public func append(_ value: T) {
    let newNode = Node(value: value)

    guard let tailNode = tail else {
      head = newNode
      tail = newNode
      return
    }

    newNode.previous = tailNode
    tailNode.next = newNode
    tail = newNode
  }

  public func remove(_ node: Node<T>) -> T {
    let prev = node.previous
    let next = node.next

    if let prev = prev {
      prev.next = next
    } else {
      head = next
    }

    next?.previous = prev

    if next == nil {
      tail = prev
    }

    node.previous = nil
    node.next = nil

    return node.value
  }
}

extension DoubleQueueLinkedList: CustomStringConvertible {

  public var description: String {
    var string = ""
    var current = head
    while let node = current {
      string.append("\(node.value) -> ")
      current = node.next
    }
    return string + "end"
  }
}

public class LinkedListIterator<T>: IteratorProtocol {

  private var current: Node<T>?

  init(node: Node<T>?) {
    current = node
  }

  public func next() -> Node<T>? {
    defer { current = current?.next }
    return current
  }
}

extension DoubleQueueLinkedList: Sequence {

  public func makeIterator() -> LinkedListIterator<T> {
    LinkedListIterator(node: head)
  }
}

var doubleQueue = DoubleQueueLinkedList<String>()
let ray = Node<String>(value: "Ray")
let brian = Node<String>(value: "Brian")
let eric = Node<String>(value: "Eric")
let lucas = Node<String>(value: "Lucas")
doubleQueue.enqueue(ray, to: .back)
doubleQueue.enqueue(brian, to: .back)
doubleQueue.enqueue(eric, to: .back)
print(doubleQueue.peek(from: .front))
doubleQueue.enqueue(lucas, to: .front)
print(doubleQueue.peek(from: .front))
