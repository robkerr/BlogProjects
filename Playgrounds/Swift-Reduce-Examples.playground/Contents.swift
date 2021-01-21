import Cocoa

let pageCounts = [992, 108, 378, 1152, 244, 206, 164, 544, 336, 312]
let totalPages0 = pageCounts.reduce(0, -)
print("Total Pages: \(totalPages0)")

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


let totalPages = books.reduce(0) { (current, next)  in
    return (current + next.pageCount)
}
print("Total Pages: \(totalPages)")

let averagePrice = books.reduce(0.0) { (current, next) in
    return current + (next.price / Double(books.count))
}
print("Average Price: \(averagePrice)")

let titleWords = "The Great Gatsby".split(separator: " ")
let reversedWords = titleWords.reversed().reduce("") { (result, next) -> String in
    return "\(result)\(result.count > 0 ? " " : "")\(next)"
}
print(reversedWords)


let bt = books.compactMap { (book) -> Book? in
    let titleWords = book.title.split(separator: " ")
    if titleWords.count > 1 {
        return Book(
            title: titleWords.reversed()
                             .reduce("") { (result, next) -> String in
                return "\(result) \(next)"
                       .trimmingCharacters(in: .whitespaces)
            }
            , price: book.price, pageCount: book.pageCount)
    } else {
        return nil
    }
}
dumpBooks(bt, "Reversed")
