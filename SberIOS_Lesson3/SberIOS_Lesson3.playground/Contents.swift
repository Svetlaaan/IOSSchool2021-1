import UIKit

// Задание: Реализовать COW на своей структуре со свойством reference type (isKnownUniquelyReferenced)

final class Reference<T> {
    var value: T
    
    init(value: T) {
        self.value = value
    }
}

struct SomeCustomStruct<T> {
    var ref: Reference<T>
    
    init(value: T) {
        ref = Reference(value: value)
    }
    
    var value: T {
        get { return ref.value }
        set {
            guard (isKnownUniquelyReferenced(&ref)) else {
                // если есть несколько сильных ссылок на объект, то создадим новый объект c переданным значением value
                ref = Reference(value: newValue)
                return
            }
            // если на объект указывает только одна сильная ссылка, то просто меняем значение
            ref.value = newValue
        }
    }
}

// Выводит адрес объекта
func printAddress(of value: AnyObject) {
    print("\(Unmanaged.passUnretained(value).toOpaque())")
}

var struct1 = SomeCustomStruct(value: "Initial value")
var struct2 = struct1

// Проверим, что ссылаются на один и тот же участок памяти
printAddress(of: struct1.ref)
printAddress(of: struct2.ref)
// Проверим, что содержат одинаковое значение
print(struct1.value)
print(struct2.value)

struct2.value = "New value"

// Проверим, что после изменения в struct2, ссылаются на разные участки памяти
printAddress(of: struct1.ref)
printAddress(of: struct2.ref)
// Проверим, что содержат разные значения
print(struct1.value)
print(struct2.value)
