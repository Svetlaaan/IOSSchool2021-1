import UIKit

// MARK: - Задача 3*. К выполнению необязательна.

struct LinkedList<T> {
    var head: LinkedListNode<T>
    
    init(head: LinkedListNode<T>) {
        self.head = head
    }
}

indirect enum LinkedListNode<T> {
    
    case value(element: T, next: LinkedListNode<T>)
    case end
}

let linkedList = LinkedListNode.value(element: "A", next: .value(element: "B", next: .value(element: "C", next: .end)))

