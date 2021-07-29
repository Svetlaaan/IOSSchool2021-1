import UIKit

// Реализовать проверяльщик примеров.
// 1. Есть массив строк. Но это не обычные строки - это примеры.
// Пример - это строка формата «32 + 16 = 48». В нём два числа слева от равно, одно число справа.
// Операции: сложение и вычитание.
//
// 2. Есть функция checkHomework, которая:
//    1. Принимает массив примеров
//    2. И возвращает:
//        1. Если больше 75% ошибок в примерах - функция возвращает список всех примеров с ошибками и подписью «делай заново»
//        2. Если пример решён верно - возвращает строку «молодец»
//        3. Если нет примеров - возвращает строку «нет примеров»
//    3. Если ей на вход дать хотя бы один невалидный пример - выводит "переделывай" и не оценивает другие примеры
//
// 3. Есть функция checkTask:
//    1. Она принимает пример
//    2. Если это не пример - надо кинуть исключение
//    3. Если пример решён правильно - возвращаем строку с похвалой. Если нет - возвращаем ошибку с правильным ответом
//-------------------------------------------------------------------------------------------------------------------

// Для вывода строки с ошибкой
struct HomeworkError: Error {
    var errorMessage: String
}

// Варианты выполнения функции checkTask()
enum TaskResults<Error, Value> {
    case notATask(error: Error)
    case wrongAnswer(error: Error)
    case rightAnswer(message: Value)
}

// Варианты выполнения функции checkHomework()
enum HomeWorkResults<Error, Value> {
    case success(Value)
    case failure(Error)
    case outOf75PercentsMistakes(error: Error, tasksWithMistakes: [Value] )
}

func checkTask(task: String) throws ->  TaskResults<HomeworkError, String> {
        
    // Разделяем пример на элементы
    let elements = task.components(separatedBy: " ")
    
    // Обработка вариантов невалидных примеров:
    // - Если в примере не 5 элементов
    // - Если в примере нет знака "=" или он не на своем месте
    // - Если в примере операция отличная от "+"/"-"
    if elements.count != 5
        || elements[3] != "="
        || !(elements[1] == "+" || elements[1] == "-") {
        let error = HomeworkError(errorMessage: "Unexpected task. Example of task: (1) 1 + 2 = 3, (2) 3 - 2 = 1. Your task: \(task)")
        throw error
    }
    
    var correctResult = 0
    
    if let lhs = Int(elements[0]),
       let rhs = Int(elements[2]),
       let result = Int(elements[4]) {
        // Вычисление верного ответа
        if elements[1] == "+" {
            correctResult = lhs + rhs
        } else if elements[1] == "-" {
            correctResult = lhs - rhs
        }
        // Пример решен неверно
        if correctResult != result {
            let error = HomeworkError(errorMessage: "Wrong answer :( Correct answer is \(correctResult), your answer is \(result)")
            return .wrongAnswer(error: error)
        }
        // Пример решен верно
        return .rightAnswer(message: "Good work! Your answer is right")
    } else {
        // Обработка варианта невалидного примера
        // Если элементы нельзя привести к Int, т.е. не числа
        let error = HomeworkError(errorMessage: "Error: Unexpected task. Example of task: (1) 1 + 2 = 3, (2) 3 - 2 = 1 . Your task: \(task)")
        throw error
    }
}


func checkHomework(tasks: [String]?) -> HomeWorkResults<HomeworkError, String> {
    
    // Нет примеров
    if tasks?.count == 0 {
        let error = HomeworkError(errorMessage: "There are no tasks in homework")
        return .failure(error)
    }
    
    var counterFailedTasks = 0
    var wrongTasks = [String]()
    
    if let tasks = tasks {
        for task in tasks {
            let check = try? checkTask(task: task)
            if let check = check {
                switch check {
                case .wrongAnswer(let message):
                    counterFailedTasks += 1
                    wrongTasks.append(task)
                    print(message)
                default:
                    print("Your answer is right")
                }
            } else {
                let error = HomeworkError(errorMessage: "Invalid task. Do your homework again")
                return .failure(error)
            }
        }
    }
    
    // В домашней работе больше 75% ошибок в примерах
    if (Double(counterFailedTasks) / Double(tasks!.count)) > 0.75 {
        let error = HomeworkError(errorMessage: "Homework completed less than 75%. Do your homework again")
        return .outOf75PercentsMistakes(error: error, tasksWithMistakes: wrongTasks)
    }
    
    // Домашняя работа зачтена
    return .success("Homework is done correctly!")
}

let correctTasks = ["22 + 22 = 44",
                    "1 + 1 = 2",
                    "999 - 333 = 666"]

let withIncorrectTasks = ["22 + 22 = 44",
                     "1 + 1 = 222",
                     "999 + 333 = 666",
                     "0 - 0 = 1",
                     "0 - 0 = 10"]

let withInvalidTask = ["22 + 22 = 44",
                       "1 + 1 = 2",
                       "one + one = two",
                       "999 - 333 = 666"]

checkHomework(tasks: correctTasks)
