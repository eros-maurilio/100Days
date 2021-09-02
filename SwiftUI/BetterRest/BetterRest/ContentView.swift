//
//  ContentView.swift
//  BetterRest
//
//  Created by Eros Maurilio on 30/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defautWakeTime
    @State private var sleepAmout = 8.0
    @State private var coffeAmout = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section(header: Text("When do you want to wake up?")) {
                    Stepper(value: $sleepAmout, in: 4...12, step: 0.25) {
                        Text("\(sleepAmout, specifier: "%g")")
                    }
                }
                
                Section(header: Text("Daily coffe intake")){
                    Picker("Coffe amount", selection: $coffeAmout) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Text(coffeAmout == 1 ? "1 Cup" : "\(coffeAmout) cups")
                }
                
                Section(header: Text("Calculated Bed Time")) {
                    Text("\(calculateBedTime)")
                        .font(.title)

                }
            }
            .navigationBarTitle("Better Rest")
        }
    }
    
    static var defautWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var calculateBedTime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.hour ?? 0) * 60
        
        var message: String
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmout, coffee: Double(coffeAmout))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            message = formatter.string(from: sleepTime)
            
        } catch {
            message = "Sorry, there was a problem calculating your bedtime."
        }
        
        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
