import UIKit

// MARK: - Abstract Factory
// Порождающий паттерн проектирования, который позволяет создавать
// семейства связанных объектов, не привязываясь к конкретным классам создаваемых объектов.

// Интерфейс Абстрактной Фабрики объявляет набор методов, которые возвращают
// различные абстрактные продукты. Эти продукты называются семейством и связаны
// темой или концепцией высокого уровня.
protocol AbstractFactory {
    func createDogFood() -> DogFood
    func createCatFood() -> CatFood
}

// Каждый отдельный продукт семейства продуктов должен иметь базовый интерфейс.
// Все вариации продукта должны реализовывать этот интерфейс.
protocol DogFood {
    var taste: String {get}
    var type: String {get}
}

protocol CatFood {
    var taste: String {get}
    var type: String {get}
}

// Конкретные Продукты, которые создаются соответствующими Конкретными Фабриками
class FoodForSeniorDogs: DogFood {
    var taste: String = "Chicken"
    var type: String = "Senior dogs"
}

class FoodForSeniorCats: CatFood {
    var taste: String = "Chicken"
    var type: String = "Senior cats"
}

class FoodForAdultCats: CatFood {
    var taste: String = "Lamb"
    var type: String = "Adult cats"
}

class FoodForAdultDogs: DogFood {
    var taste: String = "Lamb"
    var type: String = "Adult dogs"
}

// Конкретная Фабрика производит семейство продуктов одной вариации.
class FoodForSeniorPetsFactory: AbstractFactory {
    func createDogFood() -> DogFood {
        return FoodForSeniorDogs()
    }
    
    func createCatFood() -> CatFood {
        return FoodForSeniorCats()
    }
    
}

class FoodForAdultPetsFactory: AbstractFactory {
    func createDogFood() -> DogFood {
        return FoodForAdultDogs()
    }
    
    func createCatFood() -> CatFood {
        return FoodForAdultCats()
    }
}

// Клиентский код работает с фабриками и продуктами только через абстрактные
// типы: Абстрактная Фабрика и Абстрактный Продукт.
class Client {
    static func getPetFood(factory: AbstractFactory) {
        let catFood = factory.createCatFood()
        let dogFood = factory.createDogFood()
        
        print("Food for \(catFood.type) with taste \(catFood.taste)")
        print("Food for \(dogFood.type) with taste \(dogFood.taste)\n")
    }
}

Client.getPetFood(factory: FoodForSeniorPetsFactory())
Client.getPetFood(factory: FoodForAdultPetsFactory())
