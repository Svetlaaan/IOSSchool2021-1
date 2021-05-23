import UIKit

// MARK: - Builder
// Порождающий паттерн проектирования, который позволяет создавать сложные объекты пошагово.
// Строитель даёт возможность использовать один и тот же код строительства для получения разных представлений объектов.

class House {
    var walls: Int?
    var windows: Int?
    var typeWalls: String?
    var typeStyle: String?
}

// Интерфейс Строителя объявляет создающие методы для различных частей объектов Продуктов.
protocol Builder {
    func reset()
    func setWalls()
    func setWindows()
    func setTypeWalls()
    func setTypeStyle()
}

// Классы Конкретного Строителя следуют интерфейсу Строителя и предоставляют
// конкретные реализации шагов построения.
class SimpleHouseBuilder: Builder {
    // Новый экземпляр строителя должен содержать пустой объект продукта,
    // который используется в дальнейшей сборке.
    private var house: House = House()
    
    func reset() {
        self.house = House()
    }
    
    // Все этапы производства работают с одним и тем же экземпляром продукта.
    func setWalls() {
        house.walls = 4
    }
    
    func setWindows() {
        house.windows = 1
    }
    
    func setTypeWalls() {
        house.typeWalls = "Brick"
    }
    
    func setTypeStyle() {
        house.typeStyle = "Simple"
    }
    
    func getResult() -> House {
        let result = self.house
        reset()
        return result
    }
}

class LuxuryHouseBuilder: Builder {
    // Новый экземпляр строителя должен содержать пустой объект продукта,
    // который используется в дальнейшей сборке.
    private var house: House = House()
    
    func reset() {
        self.house = House()
    }
    
    // Все этапы производства работают с одним и тем же экземпляром продукта.
    func setWalls() {
        house.walls = 14
    }
    
    func setWindows() {
        house.windows = 30
    }
    
    func setTypeWalls() {
        house.typeWalls = "Gold"
    }
    
    func setTypeStyle() {
        house.typeStyle = "Luxury"
    }
    
    func getResult() -> House {
        let result = self.house
        reset()
        return result
    }
}

class Director {
    private var builder: Builder?
    
    // Директор работает с любым экземпляром строителя, который передаётся ему
    // клиентским кодом. Таким образом, клиентский код может изменить конечный
    // тип вновь собираемого продукта.
    func setBuilder(builder: Builder) {
        self.builder = builder
    }
    
    func createHouse() {
        self.builder?.setTypeStyle()
        self.builder?.setTypeWalls()
        self.builder?.setWalls()
        self.builder?.setWindows()
    }
}

// Клиентский код создаёт объект-строитель, передаёт его директору, а затем
// инициирует процесс построения.
class Client {
    static func createSimpleHouse(director: Director) -> House {
        let builder = SimpleHouseBuilder()
        director.setBuilder(builder: builder)
        director.createHouse()
        print("Simple house is ready")
        return builder.getResult()
    }
    
    static func createLuxuryHouse(director: Director) -> House {
        let builder = LuxuryHouseBuilder()
        director.setBuilder(builder: builder)
        director.createHouse()
        print("Luxury house is ready")
        return builder.getResult()
    }
}

let director = Director()
Client.createSimpleHouse(director: director)
Client.createLuxuryHouse(director: director)
