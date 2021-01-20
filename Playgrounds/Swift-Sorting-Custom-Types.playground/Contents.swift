import Cocoa


struct Book: Comparable {
    let title: String
    let price: Double
    let pageCount: Int
    static func < (lhs: Book, rhs: Book) -> Bool {
        return lhs.titleWithoutThe() < rhs.titleWithoutThe()
    }
    
    private func titleWithoutThe() -> String {
        let prefix = "The"
        guard Locale.current.languageCode?.starts(with: "en") == true,
              title.lowercased().hasPrefix(prefix.lowercased()) else { return title }
        
        return String(title.dropFirst(prefix.count).trimmingCharacters(in: .whitespaces))
    }
}

func dumpBooks(_ books: [Book], _ title: String = "") {
    print("============ \(title) ============")
    for book in books {
        let title = book.title.padding(toLength: 25, withPad: " ", startingAt: 0)
        let price = "\(book.price)".padding(toLength: 6, withPad: " ", startingAt: 0)
        let pages = "\(book.pageCount)".padding(toLength: 6, withPad: " ", startingAt: 0)
        print("\(title) \(price) \(pages)")
    }
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

let avgPrice:Double? = books.count > 0 ? books.reduce(0.0, { $0 + $1.price}) / Double(books.count) : nil
print(avgPrice ?? -999)

let sortedBooks = books.sorted()
dumpBooks(sortedBooks, "Default Sort")

let b = sortedBooks[0] == sortedBooks[0]

extension String {
    func theToEnd() -> String {
        let prefix = "The"
        guard Locale.current.languageCode?.starts(with: "en") == true,
              self.lowercased().hasPrefix(prefix.lowercased()) else { return self }

        return String(self.dropFirst(prefix.count).trimmingCharacters(in: .whitespaces))
    }
}

let sortedWithoutThe2 = books.sorted { (lhs, rhs) -> Bool in
    return lhs.title.theToEnd() < rhs.title.theToEnd()
}
dumpBooks(sortedWithoutThe2, "Without The")

let sortedByPageCount = books.sorted { (lhs, rhs) -> Bool in
    return lhs.pageCount > rhs.pageCount // reverse the sort
}
dumpBooks(sortedByPageCount, "Page Count")


