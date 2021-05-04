import UIKit

// MARK: - Задача 1 "Сделать так, чтобы закомментированный код работал"

protocol Sumable {
    // Тип, который будет подчиняться протоколу Sumable,
    // будет использовать свой тип в качестве Self
    static func +(lhs: Self, rhs: Self) -> Self
}

// Т.к. реализация метода + есть в каждом из типов ниже,
// добавлять ее дополнительно в extension не нужно
extension Int: Sumable {}
extension Double: Sumable {}
extension String: Sumable {}

func sumTwoValues<T: Sumable>(_ a: T, _ b: T) -> T {
    let result = a + b
    return result
}

let a = 25.0
let b = 34.0

let resultDouble = sumTwoValues(a, b)
print(resultDouble)

let c = "ABC"
let d = "DEF"

let resultString = sumTwoValues(c, d)
print(resultString)

