//
//  Substraction_Cancellation_Excersise_3App.swift
//  Substraction Cancellation Excersise 3
//
//  Created by PHYS 440 Marco on 1/26/24.
//

import SwiftUI
import Observation

@main
struct Substraction_Cancellation_Excersise_3App: App {
    
    @State var plotData = PlotClass()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(plotData)
        }
    }
}
