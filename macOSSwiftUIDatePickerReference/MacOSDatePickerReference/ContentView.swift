//
//  ContentView.swift
//  MacOSDatePickerReference
//
//  Created by Rob Kerr on 1/29/21.
//

import SwiftUI

enum PickerStyle : String {
    case basic = "Default",
         dateOnly = "Date Only",
         hourAndMinute = "Hour and Minute",
         graphical = "Graphical Style",
         customColors = "Custom Colors",
         historicalDaysOnly = "Before Now Only",
         futureDaysOnly = "Now and Future Only",
         dateRange = "Date Range",
         macOSField = "Field (macOS only)",
         macOSStepper = "Stepper (macOS only)"
}


struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var pickerStyle = PickerStyle.basic
    
    var pickerDateRange : ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2020, month: 12, day: 15)
        let endComponents = DateComponents(year: 2020, month: 12, day: 30, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!...calendar.date(from:endComponents)!
    }
    
    
    var body: some View {
        VStack {
            Menu("Picker Style") {
                Group {
                    Button( action : { pickerStyle = .basic }) { Text(PickerStyle.basic.rawValue)}
                    Button( action : { pickerStyle = .dateOnly }) { Text(PickerStyle.dateOnly.rawValue)}
                    Button( action : { pickerStyle = .hourAndMinute }) { Text(PickerStyle.hourAndMinute.rawValue)}
                    Button( action : { pickerStyle = .graphical }) { Text(PickerStyle.graphical.rawValue)}
                    Button( action : { pickerStyle = .customColors }) { Text(PickerStyle.customColors.rawValue)}
                    Button( action : { pickerStyle = .historicalDaysOnly }) { Text(PickerStyle.historicalDaysOnly.rawValue)}
                }
                Button( action : { pickerStyle = .futureDaysOnly }) { Text(PickerStyle.futureDaysOnly.rawValue)}
                Button( action : { pickerStyle = .dateRange }) { Text(PickerStyle.dateRange.rawValue)}
                Button( action : { pickerStyle = .macOSField }) { Text(PickerStyle.macOSField.rawValue)}
                Button( action : { pickerStyle = .macOSStepper }) { Text(PickerStyle.macOSStepper.rawValue)}
            }
            .padding(50)
            
            Text("\(formatDate(selectedDate))")
                .padding(20)
            
            switch pickerStyle {
                case .dateOnly:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .date)
                        .padding(50)
                case .hourAndMinute:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .padding(50)
                case .graphical:
                    DatePicker("Prompt Text", selection: $selectedDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(50)
                case .dateRange:
                    DatePicker("Prompt Text", selection: $selectedDate,
                               in: pickerDateRange, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .padding(50)
                case .historicalDaysOnly:
                    DatePicker("Prompt Text", selection: $selectedDate, in: ...Date())
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(50)
                case .futureDaysOnly:
                    DatePicker("Prompt Text", selection: $selectedDate, in: Date()...)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(50)
                case .customColors:
                    DatePicker("Prompt Text", selection: $selectedDate)
                        .accentColor(.purple)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.purple)
                                        .opacity(0.2)
                                        .shadow(radius: 1, x: 4, y: 4))
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(50)
                case .macOSField:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(FieldDatePickerStyle())
                        .padding(50)
                case .macOSStepper:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(StepperFieldDatePickerStyle())
                        .padding(50)

                default:
                    DatePicker("Prompt Text", selection: $selectedDate)
                        .padding(50)
            }
        }    }
    
    func formatDate(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df.string(from: date)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
