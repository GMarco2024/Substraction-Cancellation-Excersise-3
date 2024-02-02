//
//  ContentView.swift
//  HW 2
//
//  Problem 3b - Making a Log-Log Plot of Equation 3
//  Created by PHYS 440 Marco on 1/24/24.
//

import Foundation

// Function to calculate Equation 3
func calculateEquation3(N: Int) -> Double {
    let upSum = calculateUpwardSum(N: N)
    let downSum = calculateDownwardSum(N: N)

    // Calculate Equation 3
    let result = (upSum - downSum) / (abs(upSum) + abs(downSum))

    return result
}

// Helper functions for calculating sums
func calculateUpwardSum(N: Int) -> Double {
    var sum: Double = 0.0
    for n in 1...N {
        sum += 1.0 / Double(n)
    }
    return sum
}

func calculateDownwardSum(N: Int) -> Double {
    var sum: Double = 0.0
    for n in (1...N).reversed() {
        sum += 1.0 / Double(n)
    }
    return sum
}










