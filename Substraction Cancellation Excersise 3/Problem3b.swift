//
//  ContentView.swift
//  HW 2
//
//  Problem 3b - Making a Log-Log Plot of Equation 3
//  Created by PHYS 440 Marco on 1/24/24.
//
import Foundation
import SwiftUI

// Function to calculate Equation 3
func calculateEquation3(N: Int) -> Double {
    let upSum = calculateUpSum(N: N)
    let downSum = calculateDownSum(N: N)

    // Calculate Equation 3
    let result = (upSum - downSum) / (abs(upSum) + abs(downSum))

    // Print intermediate results for debugging
    print(" N=\(N), \(result)")
    
    return result
}










