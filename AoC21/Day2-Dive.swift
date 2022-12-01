//
//  Day2-Dive.swift
//  AdventOfCode
//
//  Created by Daniel Abreu on 25/07/2022.
//

import XCTest

struct SubmarineMovement {
    var direction : Direction
    var amount : Int
    enum Direction { case Up, Down, Forwards, Backwards }
    
}

struct SubmarineSimplePosition {
    var x : Int = 0
    var y : Int = 0
    
    var position : Int {
        return x * y
    }
}

struct SubmarineRealPosition {
    var x : Int = 0
    var y : Int = 0
    var aim : Int = 0
    
    var position : Int {
        return x * y
    }
}



class Day2_Dive: XCTestCase {
    
    func test_exampleData() {
        let instructions = "forward 5,down 5,forward 8,up 3,down 8,forward 2"
        let movement = SubmarineMovement.parse(from: instructions)
        var start = SubmarineSimplePosition()
        
        let destination = start.applying(instruction: movement)
        
        XCTAssertEqual(destination.position, 150)
    }
    
    func test_challenge_1() {
        let destination = SubmarineSimplePosition().applying(instruction: SubmarineMovement.parse(from: CHALLENGE_INPUT))
        XCTAssertEqual(destination.position, 1893605)
    }
    
    func test_challenge_2(){
        let destination = SubmarineRealPosition().applying(instruction: SubmarineMovement.parse(from: CHALLENGE_INPUT))
        XCTAssertEqual(destination.position, 2120734350)
    }
    
    
}

extension SubmarineMovement {
    static func parse(from message: String) -> [SubmarineMovement] {
        let instructions = message.split(separator: ",")
        return instructions.map({ instruction in
            let pieces : [String] = instruction.split(separator: " ").map({ String($0) })
            let direction = pieces.first!
            let amount = Int(pieces.last!)!
            return SubmarineMovement(direction: Direction(direction), amount: amount)
        })
    }
}

extension SubmarineMovement.Direction {
    init(_ string: String) {
        let key = string.uppercased()
        if key == "UP" {
            self = .Up
        } else if key == "DOWN" {
            self = .Down
        } else if key == "FORWARD" {
            self = .Forwards
        } else {
            self = .Backwards
        }
    }
}


extension SubmarineSimplePosition {
    func applying(instruction: [SubmarineMovement]) -> SubmarineSimplePosition {
        return instruction.reduce(self, { (acc, next) in
            switch next.direction {
            case .Backwards:
                return acc.backward(by: next.amount)
            case .Forwards:
                return acc.forward(by: next.amount)
            case .Down:
                return acc.down(by: next.amount)
            case .Up:
                return acc.up(by: next.amount)
            }
        })
    }
    
    func forward(by movement: Int) -> SubmarineSimplePosition {
        return SubmarineSimplePosition(x: self.x + movement, y: self.y)
    }
    
    func backward(by movement: Int) -> SubmarineSimplePosition {
        return SubmarineSimplePosition(x: self.x - movement, y: self.y)
    }
    
    func up(by movement: Int) -> SubmarineSimplePosition {
        return SubmarineSimplePosition(x: self.x, y: self.y - movement)
    }
    
    func down(by movement: Int) -> SubmarineSimplePosition {
        return SubmarineSimplePosition(x: self.x, y: self.y + movement)
    }
}

extension SubmarineRealPosition {
    func applying(instruction: [SubmarineMovement]) -> SubmarineRealPosition {
        return instruction.reduce(self, { (acc, next) in
            switch next.direction {
            case .Backwards:
                return acc.backward(by: next.amount)
            case .Forwards:
                return acc.forward(by: next.amount)
            case .Down:
                return acc.down(by: next.amount)
            case .Up:
                return acc.up(by: next.amount)
            }
        })
    }
    
    func forward(by movement: Int) -> SubmarineRealPosition {
        SubmarineRealPosition(x: self.x + movement, y: self.y - (self.aim * movement), aim: self.aim)
    }
    
    func backward(by movement: Int) -> SubmarineRealPosition {
        SubmarineRealPosition(x: self.x - movement, y: self.y + (self.aim * movement), aim: self.aim)
    }
    
    func up(by movement: Int) -> SubmarineRealPosition {
        SubmarineRealPosition(x: self.x, y: self.y, aim: self.aim + movement)
    }
    
    func down(by movement: Int) -> SubmarineRealPosition {
        SubmarineRealPosition(x: self.x, y: self.y, aim: self.aim - movement)
    }
}

fileprivate var CHALLENGE_INPUT : String {
    return "forward 4,down 9,forward 2,forward 2,down 7,up 2,down 9,up 8,down 7,down 9,forward 4,up 6,down 2,down 5,down 1,down 5,forward 2,up 4,forward 2,forward 3,up 2,forward 6,up 8,forward 8,down 8,up 8,down 7,down 2,down 9,forward 2,forward 9,down 4,forward 8,up 6,down 3,up 9,forward 1,forward 6,up 3,forward 8,up 9,forward 1,down 9,down 3,down 7,up 2,up 7,down 5,forward 3,down 1,up 6,down 2,forward 4,down 6,down 8,forward 2,down 5,forward 6,down 5,down 7,forward 8,forward 2,down 9,up 4,forward 6,forward 4,up 6,down 9,down 7,down 9,forward 9,forward 8,down 7,up 7,forward 9,forward 8,up 1,up 4,down 3,forward 6,up 6,down 2,up 3,down 6,down 5,forward 8,forward 3,forward 8,down 4,down 4,down 5,forward 6,down 5,forward 6,down 2,down 5,up 4,down 8,up 5,forward 5,forward 6,down 9,up 5,down 2,forward 5,down 7,up 7,down 9,forward 2,down 3,down 3,forward 8,up 5,up 1,forward 1,forward 3,down 5,forward 8,forward 7,forward 8,down 5,down 8,up 2,forward 8,forward 8,down 7,forward 1,forward 7,down 6,up 4,forward 7,forward 7,down 3,up 7,forward 2,down 7,down 4,forward 5,down 8,forward 9,down 7,forward 5,up 6,up 6,down 8,down 3,forward 5,forward 3,down 8,up 7,forward 8,up 6,down 2,forward 4,up 3,up 3,down 9,down 9,up 1,up 7,forward 2,down 1,forward 9,up 7,up 6,down 2,down 3,forward 4,down 3,down 3,down 1,forward 4,forward 8,forward 6,forward 3,up 4,up 5,up 4,forward 1,up 3,down 9,up 6,forward 2,down 5,down 1,forward 8,forward 2,down 6,up 5,up 3,forward 7,forward 2,forward 7,up 9,forward 3,up 9,forward 1,down 9,forward 9,down 3,down 3,down 2,forward 9,forward 2,up 3,forward 3,down 7,down 3,forward 2,forward 1,forward 6,up 9,forward 4,down 9,down 8,up 3,up 5,forward 8,down 9,forward 5,forward 4,down 5,up 4,forward 7,forward 3,down 9,forward 7,down 2,down 7,forward 3,up 3,forward 7,down 9,down 4,down 8,forward 8,down 6,forward 9,forward 4,up 9,down 9,down 6,up 7,up 2,forward 2,forward 7,down 7,forward 9,down 6,down 2,forward 4,forward 8,down 4,forward 4,forward 4,forward 6,up 6,down 9,down 3,down 7,up 2,up 2,forward 4,down 4,forward 6,down 2,down 2,forward 1,down 1,forward 7,up 5,forward 9,forward 8,down 4,forward 8,down 5,up 4,down 8,forward 4,forward 7,down 9,down 3,forward 6,down 6,forward 6,down 9,down 6,forward 5,forward 5,up 9,down 9,down 9,down 1,down 5,forward 5,down 7,forward 3,down 6,forward 5,forward 8,down 6,forward 7,down 5,forward 4,down 4,down 9,forward 3,down 9,down 9,down 1,up 7,forward 4,up 1,up 1,forward 1,down 9,up 8,down 8,down 3,down 7,forward 4,down 5,down 5,forward 7,forward 7,forward 6,up 2,down 4,forward 8,forward 3,forward 3,forward 2,forward 4,up 9,up 1,forward 2,forward 2,forward 6,down 9,up 8,forward 4,forward 5,forward 4,down 4,down 8,forward 6,down 8,forward 9,forward 8,down 1,down 2,forward 2,up 4,up 7,forward 5,down 7,down 5,down 3,up 7,down 4,forward 8,up 8,down 1,down 2,up 6,up 8,forward 9,down 5,down 2,forward 5,forward 4,up 6,forward 7,down 3,up 5,up 9,forward 5,forward 1,down 6,down 7,forward 9,down 8,down 2,forward 9,forward 2,down 3,forward 9,down 3,down 9,up 3,forward 7,up 2,up 5,forward 3,down 9,up 1,down 2,down 4,down 6,forward 5,forward 5,up 7,up 3,down 1,down 1,up 8,down 4,forward 1,down 4,down 5,down 9,forward 7,up 2,up 1,down 7,forward 9,forward 9,forward 8,forward 9,down 5,forward 9,forward 9,up 9,down 7,down 8,forward 2,forward 9,down 1,forward 3,forward 8,up 4,down 4,forward 4,forward 3,down 7,down 3,forward 6,forward 9,forward 1,down 2,up 3,down 9,forward 5,forward 6,forward 8,up 2,up 1,down 3,up 4,forward 1,up 9,forward 4,down 1,up 2,down 8,down 9,forward 3,down 2,up 5,forward 2,down 6,down 5,down 8,down 3,down 7,down 2,forward 8,down 9,up 7,down 7,down 7,down 7,forward 4,forward 1,forward 9,up 9,forward 5,forward 8,forward 7,forward 7,down 1,forward 3,down 7,forward 2,forward 4,up 7,forward 1,down 5,forward 5,forward 1,down 8,forward 7,forward 2,up 3,down 1,up 7,down 1,down 2,forward 9,forward 6,forward 3,forward 2,down 4,forward 7,forward 7,forward 5,forward 7,forward 2,down 9,down 8,forward 8,forward 9,down 3,up 7,up 1,down 4,forward 2,forward 7,forward 3,forward 9,up 2,down 3,forward 4,down 8,down 6,down 4,down 6,down 7,forward 9,down 9,forward 8,down 1,down 1,forward 1,forward 1,down 7,down 3,down 3,forward 2,down 7,forward 8,up 7,down 5,forward 7,forward 9,down 2,forward 9,forward 3,forward 9,forward 9,down 3,forward 1,forward 7,up 8,forward 7,forward 4,forward 5,forward 6,down 4,up 3,down 5,up 8,up 5,up 6,forward 1,down 1,up 8,down 8,down 5,forward 8,up 9,down 8,forward 2,up 6,forward 3,down 3,down 8,down 4,forward 6,forward 2,down 9,up 9,down 2,down 9,up 1,down 6,up 2,down 9,forward 8,forward 3,forward 6,down 6,up 9,up 8,forward 4,down 2,forward 5,up 4,up 4,down 5,down 9,forward 3,down 1,forward 1,forward 6,forward 2,down 7,forward 7,up 5,forward 2,down 8,forward 5,down 1,down 7,forward 7,down 4,forward 7,forward 2,down 6,forward 9,forward 4,up 3,forward 8,forward 2,up 6,up 3,forward 9,forward 4,down 2,forward 6,down 1,forward 5,down 2,up 1,down 1,forward 2,forward 4,down 7,up 6,forward 4,forward 7,up 8,forward 3,down 8,forward 7,down 2,down 5,forward 3,forward 7,down 5,forward 2,forward 8,up 6,forward 8,down 7,up 3,down 2,forward 2,down 8,down 2,up 5,up 1,forward 6,down 1,forward 2,down 1,forward 6,forward 9,down 9,down 8,down 3,forward 5,forward 3,down 3,down 1,forward 4,forward 8,forward 2,down 7,forward 9,forward 4,down 4,forward 6,down 4,forward 8,down 8,down 2,up 7,down 9,down 5,up 4,down 3,up 5,forward 8,down 4,down 6,forward 1,up 2,down 6,forward 4,down 8,forward 1,up 7,forward 6,up 2,forward 1,down 8,down 2,forward 3,down 3,down 2,up 9,down 3,down 4,down 3,forward 9,down 6,forward 8,forward 8,down 1,forward 8,down 5,up 9,up 5,up 5,forward 5,forward 4,down 7,down 6,forward 9,up 4,forward 7,up 5,forward 7,down 5,down 3,forward 5,down 8,up 3,forward 4,up 2,down 1,down 6,down 6,up 3,forward 5,forward 8,down 2,forward 6,down 5,down 4,forward 9,down 6,forward 6,up 5,forward 4,forward 5,forward 1,up 6,up 2,down 8,up 4,up 2,down 3,forward 4,down 5,forward 8,up 5,forward 6,forward 9,down 6,down 3,up 3,down 2,up 9,forward 5,up 5,forward 3,forward 2,down 5,up 2,down 5,forward 8,forward 2,down 1,up 2,down 6,up 8,down 3,down 2,forward 2,down 1,forward 8,forward 2,up 6,forward 6,up 3,up 8,up 2,up 4,down 7,forward 6,down 3,down 2,forward 5,down 7,down 6,forward 1,down 4,forward 4,up 1,down 3,up 3,down 4,forward 1,down 2,forward 6,down 7,forward 3,forward 1,forward 5,down 7,down 9,forward 7,forward 2,forward 7,forward 8,down 1,down 1,up 6,forward 2,up 7,down 9,up 4,up 9,forward 9,forward 6,down 3,down 9,forward 1,forward 1,up 8,forward 6,forward 1,forward 9,down 2,down 1,forward 2,forward 9,down 9,down 6,forward 5,down 6,forward 4,down 3,forward 1,down 4,up 5,forward 6,forward 3,down 2,up 3,down 9,down 2,forward 1,down 4,up 2,down 6,forward 6,forward 7,forward 3,forward 9,up 7,up 2,forward 2,up 2,forward 1,up 2,forward 8,forward 5,down 6,up 7,down 4,down 1,up 8,forward 1,down 3,up 8,forward 8,down 6,down 1,down 6,forward 1,forward 7,up 3,forward 6,forward 1,up 3,down 5,down 1,forward 5,down 5,up 7,up 3,down 6,forward 6,up 7,forward 5,forward 2,forward 1,down 8,forward 3,down 3,forward 5,down 4,up 4,down 8,down 7,down 7,up 9,up 2,down 4,down 1,down 4,forward 9,up 8,up 4,down 2,forward 8,forward 1,down 2,up 5,down 3,down 8,down 8,down 6,down 5,forward 7,down 3,forward 5,down 6,down 9,down 2,forward 8,down 4,up 2,forward 4,down 8,down 5,down 4,forward 2,up 3,forward 4,up 3,down 8,down 2,up 8,forward 4,forward 6,down 3,forward 9,forward 6,forward 8,forward 5,forward 1,forward 5,down 3,up 2,forward 4,down 4,down 3,forward 1,forward 3,forward 7,forward 9,down 2,up 4,down 3,up 8,forward 9,down 5,up 9,down 1,up 4,forward 7,forward 2,forward 4,up 8,down 4,down 1,forward 8,down 4,down 7,up 1,down 3,down 2,forward 5,up 6,down 7,forward 2"
}
