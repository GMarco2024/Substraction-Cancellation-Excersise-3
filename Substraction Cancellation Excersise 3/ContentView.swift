//
//  ContentView.swift
//  Charts Plot Observation
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 2/11/24
//

import SwiftUI
import Charts

struct ContentView: View {
    @Environment(PlotClass.self) var plotData
    
    @State private var calculator = CalculatePlotData()
    @State var isChecked:Bool = false
    @State var tempInput = ""
    @State var selector = 0
    @State private var inputN1: String = ""
    @State private var inputN3: String = ""
    @State private var inputN2: String = ""
    @State private var errorMessage: String? = nil
    @State private var upSum: Double? = nil
    @State private var downSum: Double? = nil
    @State private var equation3Results: [Double] = []
    @State private var copiedText: String = ""
    
    var body: some View {
        
        @Bindable var plotData = plotData
        
        ScrollView{
            VStack{
                
                Text("Problem 3a - Precision of Sums")
                    .font(.title)
                    .underline()
                
                Image("S Up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    
                Image("S Down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                
                Text("This calculates S^(up) and S^(down) as functions of N.")
                    .font(.headline)
                    .fontWeight(.regular)
                
                // Text box for entering value of N
                TextField("Enter N", text: $inputN1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: inputN1) { newValue in
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
                        if let userN = Int(inputN1) {
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
                
                Text("Problem 3b - Generating Log-Log Plot")
                    .font(.title)
                    .underline()
                
                Image("Equation 3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.vertical, -125)
                
                // Text box for entering value of N (separate from the first N)
                TextField("Enter Another Value for N", text: $inputN2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Button to calculate
                Button("Calculate") {
                    // Perform calculations for each iteration specified by the user
                    if let userN2 = Int(inputN2) {
                        equation3Results = (1...userN2).map { calculateEquation3(N: $0) }
                    }
                }
                .padding()
                
                Text("Results of \(inputN2) iterations of Equation 3:")
                    .font(.headline)
                
                
                
                Text(equation3Results.map { "\($0)" }.joined(separator: "\n"))
                    .padding()
                
                // Button to copy the content of the text view
                Button("Copy") {
                    copiedText = equation3Results.map { "\($0)" }.joined(separator: "\n")
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(copiedText, forType: .string)
                }
                .padding()
                
                Text("Equation 3 Plotted versus N")
                    .font(.title)
                    .underline()
                    .padding()
                
                Group{
                    
                    HStack(alignment: .center, spacing: 0) {
                        
                        Text($plotData.plotArray[selector].changingPlotParameters.yLabel.wrappedValue)
                            .rotationEffect(Angle(degrees: -90))
                            .foregroundColor(.red)
                            .padding()
                        VStack {
                            Chart($plotData.plotArray[selector].plotData.wrappedValue) {
                                LineMark(
                                    x: .value("Position", $0.xVal),
                                    y: .value("Height", $0.yVal)
                                    
                                )
                                .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                                PointMark(x: .value("Position", $0.xVal), y: .value("Height", $0.yVal))
                                
                                    .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                                
                                
                            }
                            .chartYScale(domain: [ plotData.plotArray[selector].changingPlotParameters.yMin ,  plotData.plotArray[selector].changingPlotParameters.yMax ])
                            .chartXScale(domain: [ plotData.plotArray[selector].changingPlotParameters.xMin ,  plotData.plotArray[selector].changingPlotParameters.xMax ])
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .padding()
                            Text($plotData.plotArray[selector].changingPlotParameters.xLabel.wrappedValue)
                                .foregroundColor(.red)
                        }
                    }
                    // .frame(width: 350, height: 400, alignment: .center)
                    .frame(alignment: .center)
                    
                }
                
                .padding()
                
                Divider()
                
                Button("plotSN3", action: {
                    
                    Task.init{
                        
                        self.selector = 0
                        await self.calculate()
                    }
                    
                }
                )
                .padding()
                
            }
        }
    }
    
    @MainActor func setupPlotDataModel(selector: Int){
        
        calculator.plotDataModel = self.plotData.plotArray[selector]
    }
    
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate() async {
        
        //pass the plotDataModel to the Calculator
        
        await setupPlotDataModel(selector: 0)
        
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
            
            
            taskGroup.addTask {
                
                
                
                //Calculate the new plotting data and place in the plotDataModel
                await calculator.plotSN3()
                
            }
        }
    }
}
#Preview {
    ContentView()
}
