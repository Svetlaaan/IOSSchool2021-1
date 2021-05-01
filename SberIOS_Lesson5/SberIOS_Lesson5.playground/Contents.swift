import Foundation

// MARK: DIRECT DISPATCH
// +: Быстрая
// -: Нет полиморфизма и наследования

// 1 пример Direct Dispatch
struct Dog {
    
    let name: String
    let breed: String
    
    func dogInfo() {
        print("This is \(name), his breed is \(breed)")
    }
}

let dog = Dog(name: "Sam", breed: "German Shepherd")
dog.dogInfo() // Direct Dispatch

// 2 пример Direct Dispatch
class SomeClass {}

extension SomeClass {
    
    func sayHello() {
        print("Hello!")
    }
}

let testClass = SomeClass()
testClass.sayHello() // Direct Dispatch

// 3 пример Direct Dispatch
final class SomeClass2 {
    var a: Int
    
    init(a: Int) {
        self.a = a
    }
    
    func sayHello() {
        print("Hello!")
    }
}

let someClass = SomeClass2(a: 1)
someClass.sayHello() // Direct Dispatch



// MARK: WITNESS TABLE
// +: Есть полиморфизм
// -: Медленнее Direct dispatch, нет наследования

protocol Callable {
    
    var name: String { get }
    func callPet()
}

struct Cat: Callable {
    
    let name: String
    
    func callPet() {
        print("\(name) please come here!")
    }
}

let cat: Callable = Cat(name: "Fluffy")
cat.callPet() // Witness table



// MARK: VIRTUAL TABLE
// +: Есть полиморфизм и наследование
// -: Затраты на компиляцию

class Pet {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func callPet() {
        print("\(name) please come here!")
    }
}

let kitty = Pet(name: "Barsik")
kitty.callPet() // Virtual table

class Puppy: Pet {
    
    override func callPet() {
        print("\(name) come here quickly!")
    }
    
    func pupBark() {
        print("Woof! Woof!")
    }
}

let puppy: Pet = Puppy(name: "Rex")
puppy.callPet() // Virtual table



// MESSAGE DISPATCH
// +: позволяет использовать KVC/KVO, Method Swizzling
// -: Самый медленный

@objcMembers
class MyClass1: NSObject {
    
    dynamic func someMethod() {
        print("Hello!")
    }
}

@objcMembers
class MyClass2: MyClass1 {
    
    override dynamic func someMethod() {
        print("Goodbye!")
    }
}

let myClass = MyClass2()
myClass.someMethod()
