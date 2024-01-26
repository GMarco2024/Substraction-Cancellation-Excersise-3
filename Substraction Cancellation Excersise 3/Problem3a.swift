//
//  Problem3a.swift
//  HW 2
//
//  Problem 3a - Write a program that calculates S^(up) and S^(down)
//  Created by PHYS 440 Marco on 1/24/24.
//

import Foundation

// This function to calculate S^(up)
func calculateUpSum(N: Int) -> Double {
    var sum: Double = 0.0
    for n in 1...N {
        sum += 1.0 / Double(n)
    }
    return sum
}

// This function to calculate S^(down)
func calculateDownSum(N: Int) -> Double {
    var sum: Double = 0.0
    for n in (1...N).reversed() {
        sum += 1.0 / Double(n)
    }
    return sum
}

// This function to calculate S^(up) and S^(down) for a given N
func calculateSumsForN(N: Int) {
    let upSum = calculateUpSum(N: N)
    let downSum = calculateDownSum(N: N)

    // This of course, prints the results for the GUI in which we are trying to do
    print("S^(up) for N=\(N): \(upSum)")
    print("S^(down) for N=\(N): \(downSum)")
}
