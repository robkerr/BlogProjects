import Cocoa

struct Book {
    let title: String
    let price: Double
    let pageCount: Int
}

let books:[Book] = [
    Book(title: "Don Quixote", price: 9.99, pageCount: 992),
    Book(title: "The Great Gatsby", price: 14.99, pageCount: 108),
    Book(title: "Moby Dick", price: 13.45, pageCount: 378),
    Book(title: "War and Peach", price: 10.89, pageCount: 1152),
    Book(title: "Hamlet", price: 11.61, pageCount: 244),
    Book(title: "The Odyssey", price: 14.99, pageCount: 206),
    Book(title: "The Abbot", price: 8.49, pageCount: 164),
    Book(title: "Catch-22", price: 20.06, pageCount: 544),
    Book(title: "To Kill a Mockingbird", price: 7.19, pageCount: 336),
    Book(title: "Gulliver's Travels", price: 13.99, pageCount: 312)
]

func dumpBooks(_ books: [Book?], _ title: String = "") {
    print("============ \(title) ============")
    for book in books {
        if let book = book {
            let title = book.title.padding(toLength: 25, withPad: " ", startingAt: 0)
            let price = "\(book.price)".padding(toLength: 6, withPad: " ", startingAt: 0)
            let pages = "\(book.pageCount)".padding(toLength: 6, withPad: " ", startingAt: 0)
            print("\(title) \(price) \(pages)")
        } else {
            print("")
        }
        
    }
}


//let newPriceList = books.map { Book (title: $0.title, price: $0.price * 1.10, pageCount: $0.pageCount)}
//dumpBooks(newPriceList, "Update prices")

let bt = books.map { (book) -> Book? in
    let titleWords = book.title.split(separator: " ")
    print("Titlewords = \(titleWords)")
    if titleWords.count > 1 {
        let reversedWords = titleWords.reversed().reduce("") { (result, next) -> String in
            return "\(result)\(result.count > 0 ? " " : "")\(next)"
        }
        return Book(title: reversedWords, price: book.price, pageCount: book.pageCount)
    } else {
        return nil
    }
}

//dumpBooks(bt, "map")

let bt2 = books.compactMap { (book) -> Book? in
    let titleWords = book.title.split(separator: " ")
    print("Titlewords = \(titleWords)")
    if titleWords.count > 1 {
        let reversedWords = titleWords.reversed().reduce("") { (result, next) -> String in
            return "\(result)\(result.count > 0 ? " " : "")\(next)"
        }
        return Book(title: reversedWords, price: book.price, pageCount: book.pageCount)
    } else {
        return nil
    }
}
//dumpBooks(bt2, "compactMap")


let bt3 = books.map { (book) -> Book? in
    let titleWords = book.title.split(separator: " ")
    if titleWords.count > 1 {
        return Book(title: book.title, price: book.price, pageCount: book.pageCount)
    } else {
        return nil
    }
}

//dumpBooks(bt3, "map")

let bt4 = books.compactMap { (book) -> Book? in
    let titleWords = book.title.split(separator: " ")
    if titleWords.count > 1 {
        return Book(title: book.title, price: book.price, pageCount: book.pageCount)
    } else {
        return nil
    }
}
//dumpBooks(bt4, "map")


let bt5 = books.map { (book) -> Book? in
    let titleWords = book.title.split(separator: " ")
    if titleWords.count > 1 {
        return Book(title: book.title, price: book.price, pageCount: book.pageCount)
    } else {
        return nil
    }
}.filter { $0 != nil }

//dumpBooks(bt5, "map with filter")


let booksByPriceRange =
[
    [
        Book(title: "Don Quixote", price: 9.99, pageCount: 992),
        Book(title: "The Abbot", price: 8.49, pageCount: 164),
        Book(title: "To Kill a Mockingbird", price: 7.19, pageCount: 336),
    ],
    [
        Book(title: "The Great Gatsby", price: 14.99, pageCount: 108),
        Book(title: "Moby Dick", price: 13.45, pageCount: 378),
        Book(title: "War and Peach", price: 10.89, pageCount: 1152),
        Book(title: "Hamlet", price: 11.61, pageCount: 244),
        Book(title: "The Odyssey", price: 14.99, pageCount: 206),
        Book(title: "Gulliver's Travels", price: 13.99, pageCount: 312)
    ],
    [
        Book(title: "Catch-22", price: 20.06, pageCount: 544),
    ]
]

let longBooks = booksByPriceRange.flatMap({ $0.filter({ $0.pageCount > 300}) })
dumpBooks(longBooks, "flatmap long books")
let allBooks = booksByPriceRange.flatMap({ $0 })
dumpBooks(allBooks, "flatmap all books")

let allBooks2 = booksByPriceRange.flatMap({ $0 }).filter { $0.pageCount > 300 }
dumpBooks(allBooks2, "flatmap all books")







