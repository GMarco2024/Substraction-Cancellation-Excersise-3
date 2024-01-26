//
//  ContentView.swift
//
//  Homework 2
//  GUI for Problem 3
//
//  Marco Gonzalez PHYS-440
//


import SwiftUI

struct ContentView: View {
    @State private var userInputN: String = ""
    @State private var errorMessage: String? = nil
    @State private var upSum: Double? = nil
    @State private var downSum: Double? = nil

    var body: some View {
        VStack {
            Text("Problem 3 Precision of Sums")
                .font(.title)
                .underline()

            // This is the text that goes into the GUI. We have "Enter N" for the integer as well as teh error message.
            
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

            //Button for which to activate the calculations for S^(up) and S^(down)
            
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

            // Error message in which it is in the color of red
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            // Display the results if available
            if let upSum = upSum, let downSum = downSum {
                Text("S^(up) = \(upSum)")
                Text("S^(down) = \(downSum)")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


