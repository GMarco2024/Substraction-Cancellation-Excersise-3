//
//  ContentView.swift
//  HW 2
//
//  Problem 3b
//  Created by PHYS 440 Marco on 1/24/24.
//

import Foundation
import SwiftUI

// Function to calculates Equation 3
func calculateEquation3(N: Int) -> Double {
    let upSum = calculateUpSum(N: N)
    let downSum = calculateDownSum(N: N)

    // Calculates Equation 3
    let result = (upSum - downSum) / (abs(upSum) + abs(downSum))

    return result
}

// This function is to create a log-log plot for a given N
func createLogLogPlot(N: Int) -> some View {
    // Create data points for plotting
    var dataPoints: [(Double, Double)] = []

    // Calculate Equation 3 for each N
    for n in 1...N {
        let result = calculateEquation3(N: n)
        dataPoints.append((log2(Double(n)), log2(result)))
    }

    // This creates a plot
    let path = Path { path in
        for (x, y) in dataPoints {
            path.addEllipse(in: CGRect(x: x, y: y, width: 1, height: 1))
        }
    }

    return GeometryReader { geometry in
        ZStack {
            Color.white
            path.stroke(Color.blue, lineWidth: 1)
        }
    }
}

