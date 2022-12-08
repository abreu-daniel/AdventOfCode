//
//  Day1.swift
//  AoC22
//
//  Created by Daniel Abreu on 01/12/2022.
//

import XCTest

final class Day1: XCTestCase {

    func test_puzzle1() {
        guard let input = try? String.fromFile("1a") else { XCTFail("Missing input file"); return }
         
        let calories = input.components(separatedBy: .newlines)
                            .chunked(on: { $0.isEmpty })
                            .map(Int.fromStrings)

        let caloriesSum = calories.map({ $0.sum() })
        let solution = caloriesSum.max()!
        print(solution)
    }
    
    func test_puzzle2() {
        guard let input = try? String.fromFile("1a") else { XCTFail("Missing input file"); return }
        
        let calories = input.components(separatedBy: .newlines)
                            .chunked(on: { $0.isEmpty })
                            .map(Int.fromStrings)
        
        let caloriesSum = calories.map({ $0.sum() }).sorted(by: >)
        let solution = caloriesSum[0..<3].sum()
        print(solution)
    }
}

