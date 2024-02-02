import SwiftUI

struct ContentView: View {
    @State private var userInputN: String = ""
    @State private var userInputN2: String = ""
    @State private var errorMessage: String? = nil
    @State private var upSum: Double? = nil
    @State private var downSum: Double? = nil

    var body: some View {
        VStack {
            Text("Problem 3a - Precision of Sums")
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
                    if let userN = Int(userInputN) 
                    {
                   
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
            
            Text("Problem 3b - Plot of Sums")
                .font(.title)
                .underline()
            
            Text("Log-Log plot of (S^(up) - S^(down))/(|S^(up)|-|S^(down)|).")
                .font(.headline)
                .fontWeight(.regular)
            
            // Text box for entering value of N (different from the first N of course)
            TextField("Enter Another Value for N", text: $userInputN2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
            
            // Button to calculate
            Button("Calculate") {
                
            }
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

    
    
    
    
    

