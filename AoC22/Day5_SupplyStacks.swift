//
//  Day5_SupplyStacks.swift
//  AoC22
//
//  Created by Daniel Abreu on 08/12/2022.
//

import XCTest
import Foundation

final class Day5_SupplyStacks : XCTestCase {

    fileprivate var stacks : Stack {
        [["V","C","D","R","Z","G","B","W"],
         ["G","W","F","C","B","S","T","V"],
         ["C","B","S","N","W"],
         ["Q","G","M","N","J","V","C","P"],
         ["T","S","L","F","D","H","B"],
         ["J","V","T","W","M","N"],
         ["P","F","L","C","S","T","G"],
         ["B","D","Z"],
         ["M","N","Z","W"]]
    }
    
    fileprivate var instructions : [CraneInstruction]? {
        guard let input = try? String.fromFile("5a") else { return nil }
        return input.components(separatedBy: .newlines)
            .filter({ !$0.isEmpty })
            .compactMap(CraneInstruction.from(string:))
    }
    
    func test_CrateMover9000() throws {
        guard let instructions = instructions else { throw XCTestCase.missingFileError }
        
        let topRow = instructions.reduce(stacks, { $0.apply(withFIFO: $1) })
            .compactMap(\.last)
            .joined()
        
        XCTAssertEqual(topRow, "TBVFVDZPN")
    }
    
    func test_CrateMover9001() throws {
        guard let instructions = instructions else { throw XCTestCase.missingFileError }
        
        let topRow = instructions.reduce(stacks, { $0.apply(withLIFO: $1) })
            .compactMap(\.last)
            .joined()
        
        XCTAssertEqual(topRow, "VLCWHTDSZ")
    }
}

//MARK: - Domain Layer

fileprivate typealias Stack = [[String]]

fileprivate struct CraneInstruction {
    let source : Int
    let destination : Int
    let amount : Int
}

//MARK: - Business Layer

fileprivate extension Stack {
    func apply(withFIFO op: CraneInstruction) -> Stack {
        var nextStack = self
        var source = nextStack[op.source]
        var destination = nextStack[op.destination]
        
        let crates = source.pop(op.amount)
        destination.push(crates)
        
        nextStack[op.source] = source
        nextStack[op.destination] = destination
        return nextStack
    }
    
    func apply(withLIFO op: CraneInstruction) -> Stack {
        var nextStack = self
        var source = nextStack[op.source]
        var destination = nextStack[op.destination]
        
        let crates = source.removeLast(n: op.amount)
        destination.push(crates)
        
        nextStack[op.source] = source
        nextStack[op.destination] = destination
        return nextStack
    }
}


//MARK: - Application Layer

fileprivate extension CraneInstruction {
    static func from(string str: String) -> CraneInstruction {
        let numbers = str.components(separatedBy: .whitespaces).compactMap(Int.init)
        return CraneInstruction(source: numbers[1] - 1, destination: numbers[2] - 1, amount: numbers[0])
    }
}

extension Array where Element == String {
    
    mutating func pop(_  n : Int = 1) -> [String] {
        return (0..<n).reduce([], { (acc, next) in
            return  acc + [self.removeLast()]
        })
    }

    mutating func push(_ els: [Element]) {
        self.append(contentsOf: els)
    }
        mutating func removeLast(n : Int = 1) -> [String] {
        return self.pop(n).reversed()
    }
}
