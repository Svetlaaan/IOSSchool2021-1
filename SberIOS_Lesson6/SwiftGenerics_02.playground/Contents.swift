import UIKit

// MARK: - Задача 2
// Реализовать базовый протокол для контейнеров.
// Контейнеры должны отвечать, сколько они содержат элементов,
// добавлять новые элементы и возвращать элемент по индексу.
// На основе базового протокола реализовать универсальный связанный список
// и универсальную очередь (FIFO) в виде структуры или класса.

protocol Container {
    
    // связанный тип Item
    associatedtype Item
    // Должна быть возможность получить доступ к количеству элементов в контейнере
    func count() -> Int
    // Должна быть возможность добавлять новый элемент в контейнер
    mutating func append(_ item: Item)
    // Должен возвращаться элемент контейнера по индексу
    subscript(i: Int) -> Item? { get }
}

// MARK: Реализация универсальной очереди на основе протокола Container
struct Queue<Element>: Container {
    
    private var elements = [Element]()
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    // Удаляет первый помещенный элемент из очереди и возвращает его
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
    
    // Реализация требований протокола Container:
    // - добавляет новый элемент
    mutating func append(_ item: Element) {
        elements.append(item)
    }
    
    // - возвращает количество элементов в очереди
    func count() -> Int {
        elements.count
    }
    
    // - возвращает элемент по индексу
    subscript(i: Int) -> Element? {
        if i < 0 || i > count() - 1 {
            return nil
        }
        return elements[i]
    }
}

var queue = Queue<String>()

// MARK: Проверка реализации требований протокола:
// - добавление новых элементов
queue.append("One")
queue.append("Two")
queue.append("Three")
queue.append("Four")
print("\(queue)\n")

// - получение количества элементов
print("Queue contains \(queue.count()) elements\n")

// - получение элемента через индекс
let indexOfLastElement = (queue.count()) - 1
print("First element of queue - \(String(describing: queue[0]))\nLast element of queue - \(String(describing: queue[indexOfLastElement]))")

// Для вывода информации об удаленном элементе
func printRemovedElement<T>(removedElement: T?, index: Int) {
    
    if let removedElement = removedElement {
        print("\nRemoved element of queue - \(removedElement).\nElement's index was - \(index)")
    } else {
        print("\nNothing to remove")
    }
}

// Проверка реализации метода dequeue для очереди
var removedElement = queue.dequeue()
printRemovedElement(removedElement: removedElement, index: queue.count())
removedElement = queue.dequeue()
printRemovedElement(removedElement: removedElement, index: queue.count())
removedElement = queue.dequeue()
printRemovedElement(removedElement: removedElement, index: queue.count())
removedElement = queue.dequeue()
printRemovedElement(removedElement: removedElement, index: queue.count())
removedElement = queue.dequeue()
printRemovedElement(removedElement: removedElement, index: queue.count())



// MARK: Реализация универсального односвязного списка на основе протокола Container

final class LinkedListElement<Element> {
    
    let data: Element
    var next: LinkedListElement?
    
    init(data: Element, next: LinkedListElement?) {
        self.data = data
        self.next = next
    }
}

final class LinkedList<Element>: Container {
    
    var head: LinkedListElement<Element>?
    
    init(head: LinkedListElement<Element>?) {
        self.head = head
    }
    
    func isEmpty() -> Bool {
            return head == nil
    }
    
    // удаляет последний элемент односвязного списка
    func deleteLastElement() {
        
        if var tmp = head {
            while tmp.next?.next != nil {
                tmp = tmp.next!
            }
            tmp.next = nil
        }
    }
    
    // Реализация требований протокола Container:
    // - добавляет новый элемент в конец списка
    func append(_ item: LinkedListElement<Element>) {
        
        if var element = head {
            while element.next != nil {
                element = element.next!
            }
            element.next = item
        } else {
            head = item
        }
    }
    
    // - возвращает элемент по индексу
    subscript(i: Int) -> LinkedListElement<Element>? {

        if i < 0 {
            return nil
        }
        var ind = i
        var tmpElement = head
        
        while ind > 0 && tmpElement != nil {
            ind -= 1
            tmpElement = tmpElement?.next
        }
        return tmpElement
    }
    
    // - возвращает количество элементов в односвязном списке
    func count() -> Int {
        var count = 0
        var currElement = head
        
        if currElement != nil {
            count += 1
        } else {
            return 0
        }
        
        while currElement?.next != nil {
            count += 1
            currElement = currElement?.next
        }
        return count
    }
}

let linkedList = LinkedList(head: LinkedListElement(data: "A", next: nil))

// MARK: Проверка реализации требований протокола:
// - добавление нового элемента
let element = LinkedListElement(data: "D", next: nil)
linkedList.append(LinkedListElement(data: "B", next: nil))
linkedList.append(LinkedListElement(data: "C", next: element))

// - получение элемента через индекс
let indexOfLastElementLinkedList = linkedList.count() - 1
print("\nLast element of linked list - \(String(describing: linkedList[indexOfLastElementLinkedList]?.data))")

// - получение количества элементов
print("\nLinked list contains \(linkedList.count()) elements")

linkedList.isEmpty()

