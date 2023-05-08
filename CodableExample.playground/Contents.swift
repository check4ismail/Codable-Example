import UIKit

let fruit: Fruit = try! Mapper.decode(.fruit).get()
let fruits: Fruits = try! Mapper.decode(.fruits).get()
let searchResults: SearchResults = try! Mapper.decode(.searchResult).get()

print(fruit)
print(fruits)
print(searchResults)
