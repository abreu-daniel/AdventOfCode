//
//  Utils.swift
//  AoC22
//
//  Created by Daniel Abreu on 01/12/2022.
//

import Foundation

extension String {
    static func fromFile(_ filename: String, extenison : String = ".txt") throws -> String? {
        if let file = Bundle(for: Day1.self).url(forResource: filename, withExtension: extenison){
            return try String(contentsOf: file, encoding: .utf8)
        }
        return nil
    }
}

extension Array {
    func split(on condition: (Element)->Bool) -> [[Element]] {
        let splitLocations : [Int] = self.enumerated().compactMap({ condition($1) ? $0 : nil })
        return (0..<splitLocations.count).map({ i in
            let start = i == 0 ? 0 : splitLocations[i - 1]
            let stop = splitLocations[i]
            return Array(self[start..<stop])
        })
    }
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}

extension Int {
    static func fromStrings(_ array: [String]) -> [Int] {
        return array.compactMap(Int.init)
    }
}
