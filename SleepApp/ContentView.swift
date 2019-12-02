//
//  ContentView.swift
//  SleepApp
//
//  Created by William on 12/3/19.
//  Copyright © 2019 William T. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount: Double = 8
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(verbatim: "When do you want to Wake Up?")
                    .font(.headline)
                    .lineLimit(nil)
                
                DatePicker(selection: $wakeUp, in: ...Date(), displayedComponents: .hourAndMinute) {
                    Text("")
                }.labelsHidden()
                
                Text(verbatim: "Desired Amount of Sleep")
                    .font(.headline)
                    .lineLimit(nil)
                
                // %g rounds neatly
                Stepper("\(sleepAmount, specifier: "%g") hours", value: $sleepAmount, in:4...12, step: 0.25)
                    .padding(.bottom)
                
                Text(verbatim: "Daily Coffee Intake")
                    .font(.headline)
                    .lineLimit(nil)
                
                Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20, step:1)
                
                Spacer()
            }
            .navigationBarTitle(Text("Eye Bags"))
            .navigationBarItems(trailing:
                Button(action: calculateBedtime) {
                    Text("Calculate")
                }
            )
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() {
        // go through mlmodel and show alert
        // importing the mlmodel made it available as a class
        let model = SleepModel()
        
        do {
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(coffee: Double(coffeeAmount), estimatedSleep: sleepAmount, wake: Double(hour + minute))
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = formatter.string(from: sleepTime)

        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry there was an error calculating your bedtime"
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
