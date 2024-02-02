//
//  ContentView.swift
//
//  Homework 2
//  GUI for Problem 3
//
//  Marco Gonzalez PHYS-440
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var userInputN: String = ""
    @State private var userInputN2: String = ""
    @State private var errorMessage: String? = nil
    @State private var upSum: Double? = nil
    @State private var downSum: Double? = nil
    @State private var equation3Results: [Double] = []
    @State private var copiedText: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Text("Problem 3 Precision of Sums")
                    .font(.title)
                    .underline()
                
                Text("This calculates S^(up) and S^(down) versus N.")
                    .font(.headline)
                    .fontWeight(.regular)
                
                // Text box for entering value of N
                TextField("Enter N", text: $userInputN)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: userInputN) { newValue in
                        // Validate input as integer
                        if let _ = Int(newValue) {
                            errorMessage = nil
                        } else {
                            errorMessage = "Please enter a valid integer for N"
                        }
                    }
                
                // Button for calculating sums
                Button("Calculate Sums") {
                    // Check if there's an error message
                    if errorMessage == nil {
                        // Convert user input to integer
                        if let userN = Int(userInputN) {
                            // Call functions from Problem3a.swift with user-defined N
                            upSum = calculateUpSum(N: userN)
                            downSum = calculateDownSum(N: userN)
                        }
                    } else {
                        // Print error message in red
                        print(errorMessage ?? "")
                    }
                }
                .padding()
                .foregroundColor(errorMessage == nil ? .black : .red)
                
                // Error message in red
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Display the results if available
                if let upSum = upSum, let downSum = downSum {
                    Text("S^(up) = \(upSum)")
                    Text("S^(down) = \(downSum)")
                        .padding()
                }
                
                Text("Problem 3 Precision of Sums")
                    .font(.title)
                    .underline()
                
                Text("Log-Log plot of (S^(up) - S^(down))/(|S^(up)|-|S^(down)|).")
                    .font(.headline)
                    .fontWeight(.regular)
                
                // Text box for entering value of N (separate from the first N)
                TextField("Enter Another Value for N", text: $userInputN2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .multilineTextAlignment(.center)
                
                // Button to calculate
                Button("Calculate") {
                    // Perform calculations for each iteration specified by the user
                    if let userN2 = Int(userInputN2) {
                        equation3Results = (1...userN2).map { calculateEquation3(N: $0) }
                    }
                }
                .padding()
                
                // Text view to display iterations of Equation 3
                VStack(alignment: .leading) {
                    Text("Results of \(userInputN2) iterations of Equation 3:")
                        .font(.headline)
                    
                    
                    Text(equation3Results.map { "\($0)" }.joined(separator: "\n"))
                        .padding()
                    
                    
                }
                
                // Button to copy the content of the text view
                Button("Copy") {
                    copiedText = equation3Results.map { "\($0)" }.joined(separator: "\n")
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(copiedText, forType: .string)
                }
                .padding()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







    
    
    
    
    





    
    
    
    
    

