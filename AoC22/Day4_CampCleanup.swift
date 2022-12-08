//
//  Day4_CampCleanup.swift
//  AoC22
//
//  Created by Daniel Abreu on 08/12/2022.
//

import Foundation
import XCTest

final class Day4_CampCleanup : XCTestCase {
    
    var puzzleInput : [[ClosedRange<Int>]]? {
        guard let input = try? String.fromFile("4a") else { return nil }
        return input.components(separatedBy: .newlines)
            .compactMap({ pair in
                return pair.split(separator: ",")
                    .compactMap(String.init)
                    .compactMap(ClosedRange.from(string:))
            })
    }
    
    func test_countRangesFullyContainedInAnotherRange() throws {
        guard let ranges = puzzleInput else { throw XCTestCase.missingFileError }
        
        let fullyContainedCount = ranges.reduce(0, { (acc, next) in
            guard let left = next.first, let right = next.last else { return acc }
            return areFullyContainedWithinEachOther(left, right) ? acc + 1 : acc
        })
        
        XCTAssertEqual(fullyContainedCount, 305)
    }
    
    
    func test_countRangesThatOverlap() throws {
        guard let ranges = puzzleInput else { throw XCTestCase.missingFileError }
    
        let overlappedCount = ranges.reduce(0, { (acc, next) in
            guard let left = next.first, let right = next.last else { return acc }
            return left.overlaps(right) ? acc + 1 : acc
        })
        
        XCTAssertEqual(overlappedCount, 811)
    }
    
    private func areFullyContainedWithinEachOther(_ left: ClosedRange<Int>, _ right: ClosedRange<Int>) -> Bool {
        return left.fullyContains(right) || right.fullyContains(left)
    }
}

private extension ClosedRange where Bound == Int {
    static func from(string str: String) -> ClosedRange<Int>? {
        let bounds = str.split(separator: "-").compactMap({ Int(String($0)) })
        guard let f = bounds.first, let l = bounds.last else { return nil }
        return f...l
    }
    
    func fullyContains(_ other: ClosedRange<Int>) -> Bool {
        self.lowerBound <= other.lowerBound && self.upperBound >= other.upperBound
    }
}
