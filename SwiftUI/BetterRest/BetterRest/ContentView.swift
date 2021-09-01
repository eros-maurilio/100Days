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
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Desired amout of sleep")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmout, in: 4...12, step: 0.25) {
                        Text("\(sleepAmout, specifier: "%g")")
                    }
                }
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper(value: $coffeAmout, in: 1...20) {
                        if coffeAmout == 1 {
                            Text("1 Cup")
                        } else {
                            Text("\(coffeAmout) cups")
                        }
                    }
                }
            }
            .navigationBarTitle("Better Rest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedTime,
                                           label: { /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/}))
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    static var defautWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
        
    }
    
    func calculateBedTime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.hour ?? 0) * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmout, coffee: Double(coffeAmout))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is: "
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        isShowingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
