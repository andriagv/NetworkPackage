# NetworkPackage

`NetworkPackage` არის მარტივი, მინიმალისტური ქსელური სერვისი, რომელიც JSON მონაცემების მოპოვებაში დაგეხმარებათ. ის იყენებს `URLSession`-ს და უზრუნველყოფს მკაფიო შეცდომების გამოთქმას `NetworkError` ტიპის გამოყენებით.

## შინაარსი

- [NetworkPackage](#networkpackage)
  - [დამატებითი ინფორმაციისთვის](#დამატებითი-ინფორმაციისთვის)
  - [მახასიათებლები](#მახასიათებლები)



## დამატებითი ინფორმაციისთვის

სვიფტის დოკუმენტაცია: [Swift Programming Language](https://docs.swift.org/swift-book)

## მახასიათებლები

- JSON მონაცემების მოპოვება ქსელიდან
- დეტალური შეცდომების გამოთქმა `NetworkError` გამოყენებით
- Async კომუნიკაცია `URLSession` და `completion` ბლოკის გამოყენებით

დაამატეთ NetworkPackage თქვენს პროექტში. 

**სვიფტ ფაკეიჯ მენეჯერის (Swift Package Manager) გამოყენებით:**

```swift
dependencies: [
    .package(url: "https://github.com/თქვენი-იუზერნეიმი/NetworkPackage.git", .upToNextMajor(from: "1.0.0"))
]
