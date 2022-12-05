//
//  Day2_RockPaperScissors.swift
//  AoC22
//
//  Created by Daniel Abreu on 05/12/2022.
//

import Foundation
import XCTest

final class Day2_RockPaperScissors : XCTestCase {
    
    func test_puzzle1() throws {
        guard let input = try String.fromFile("2a") else { throw XCTestCase.missingFileError }
        
        let rounds = input.components(separatedBy: .newlines)
            .compactMap(Round.from(twoShapes:))
            .reduce(0, { $0 + $1.score() })
        
        XCTAssertEqual(rounds, 11873)
    }
    
    func test_puzzle2() throws {
        guard let input = try String.fromFile("2a") else { throw XCTestCase.missingFileError }
        
        let rounds = input.components(separatedBy: .newlines)
            .compactMap(Round.from(shapeAndOutcome:))
            .reduce(0, { $0 + $1.score() })
        
        XCTAssertEqual(rounds, 12014)
    }
    
}


//MARK: - Domain Layer

enum Shape : Int {
    case rock = 1
    case paper = 2
    case scissors = 3
}

enum Outcome : Int {
    case loss = 0
    case tie = 3
    case win = 6
}

struct Round {
    var elfShape : Shape
    var playerShape : Shape?
    var outcome : Outcome?
}


//MARK: - Business Layer

extension Round {
    func score() -> Int {
        let _outcome = outcome ?? Outcome.given(elfShape: elfShape, playerShape: playerShape!)
        let _shape = playerShape ?? Shape.given(elfShape: elfShape, outcome: outcome!)
        return _outcome.rawValue + _shape.rawValue
    }
}

extension Outcome {
    static func given(elfShape: Shape, playerShape: Shape) -> Outcome {
        switch (elfShape, playerShape) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            return .win
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return .tie
        default:
            return .loss
        }
    }
}

extension Shape {
    static func given(elfShape: Shape, outcome: Outcome) -> Shape {
        switch (elfShape, outcome) {
        case (.rock, .win), (.paper, .tie), (.scissors, .loss):
            return .paper
        case (.rock, .tie), (.paper, .loss), (.scissors, .win):
            return .rock
        case (.rock, .loss), (.paper, .win), (.scissors, .tie):
            return .scissors
        }
    }
}

//MARK: - Application Layer

// Factories
extension Round {
    static func from(twoShapes input : String) -> Round? {
        let elements = input.components(separatedBy: .whitespaces)
        guard elements.count == 2 else { return nil }
        let elfShape = Shape.from(elements[0])
        let playerShape = Shape.from(elements[1])
        return Round(elfShape: elfShape, playerShape: playerShape)
    }
    
    static func from(shapeAndOutcome input : String) -> Round? {
        let elements = input.components(separatedBy: .whitespaces)
        guard elements.count == 2 else { return nil }
        let elfShape = Shape.from(elements[0])
        let outcome = Outcome.from(elements[1])
        return Round(elfShape: elfShape, outcome: outcome)
    }
}

// Mappers
extension Shape {
    static func from(_ input: String) -> Shape {
        if input == "A" || input == "X" {
            return .rock
        } else if input == "B" || input == "Y" {
            return .paper
        } else {
            return .scissors
        }
    }
}

extension Outcome {
    static func from(_ input: String) -> Outcome {
        if input == "X" {
            return .loss
        } else if input == "Y" {
            return .tie
        } else {
            return .win
        }
    }
}
