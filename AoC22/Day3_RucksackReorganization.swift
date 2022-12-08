//
//  Day3_RucksackReorganization.swift
//  AoC22
//
//  Created by Daniel Abreu on 07/12/2022.
//

import XCTest

final class Day3_RucksackReorganization : XCTestCase {
    
    func test_prioritySumOfMisplacedItems() throws {
        guard let input = try String.fromFile("3a") else { throw XCTestCase.missingFileError }
        
        let itemPrioritySum = input.components(separatedBy: .newlines)
            .compactMap({ $0.splitDownTheMiddle() })
            .map({ Rucksack(leftCompartment: $0.0, rightCompartment: $0.1) })
            .map(\.prioritySum)
            .reduce(0, +)
        
        XCTAssertEqual(itemPrioritySum, 7446)
    }
    
    func test_prioritySumOfBadges() throws {
        guard let input = try String.fromFile("3a") else { throw XCTestCase.missingFileError }
        
        let badgesSum = input.components(separatedBy: .newlines)
            .compactMap({ $0.splitDownTheMiddle() })
            .map({ Rucksack(leftCompartment: $0.0, rightCompartment: $0.1) })
            .chunked(into: 3)
            .map({ groupOfThree in
                let uniqueItems = groupOfThree.map(\.allItems).map(Set.init)
                let commonItems : Set<Character> = uniqueItems.reduce(uniqueItems.first!, { $0.intersection($1) })
                return commonItems.compactMap(\.score).sum()
            })
            .sum()
        
        XCTAssertEqual(badgesSum, 2646)
    }
}

//MARK: - Domain Layer

struct Rucksack {
    let leftCompartment : String
    let rightCompartment : String
    
    var commonItems : [Character] {
        let leftSet = Set(leftCompartment)
        let rightSet = Set(rightCompartment)
        return Array(leftSet.intersection(rightSet))
    }
    
    var allItems : String {
        leftCompartment + rightCompartment
    }
}


//MARK: - Business Layer

extension Character {
    var score : Int? {
        guard self.isLetter else { return nil }
        guard let ascii = self.asciiValue else { return nil }
        return self.isUppercase ? Int(ascii) - 38 : Int(ascii) - 96
    }
}

extension Rucksack {
    var prioritySum : Int {
        commonItems.compactMap(\.score).sum()
    }
}


//MARK: - Utils

extension String {
    func splitDownTheMiddle() -> (String, String) {
        let midPoint = self.index(self.startIndex, offsetBy: self.count / 2)
        let firstHalf = String(self[self.startIndex..<midPoint])
        let secondHalf = String(self[midPoint..<self.endIndex])
        return (firstHalf, secondHalf)
    }
}
