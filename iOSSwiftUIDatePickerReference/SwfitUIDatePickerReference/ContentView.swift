//
//  ContentView.swift
//  SwfitUIDatePickerReference
//
//  Created by Rob Kerr on 1/29/21.
//

import SwiftUI

enum PickerStyle : String {
    case basic = "Default",
         dateOnly = "Date Only",
         hourAndMinute = "Hour and Minute",
         graphical = "Graphical Style",
         wheel = "Wheel Style",
         wheelTimeOnly = "Wheel Time Only",
         wheelWithLabel = "Wheel With Label",
         wheelWithBorder = "Wheel Style with Border",
         customColors = "Custom Colors",
         historicalDaysOnly = "Before Now Only",
         futureDaysOnly = "Now and Future Only",
         dateRange = "Date Range"
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
                    Button( action : { pickerStyle = .wheel }) { Text(PickerStyle.wheel.rawValue)}
                    Button( action : { pickerStyle = .wheelTimeOnly }) { Text(PickerStyle.wheelTimeOnly.rawValue)}
                    Button( action : { pickerStyle = .wheelWithLabel }) { Text(PickerStyle.wheelWithLabel.rawValue)}
                    Button( action : { pickerStyle = .wheelWithBorder }) { Text(PickerStyle.wheelWithBorder.rawValue)}
                    Button( action : { pickerStyle = .customColors }) { Text(PickerStyle.customColors.rawValue)}
                    Button( action : { pickerStyle = .historicalDaysOnly }) { Text(PickerStyle.historicalDaysOnly.rawValue)}
                }
                Button( action : { pickerStyle = .futureDaysOnly }) { Text(PickerStyle.futureDaysOnly.rawValue)}
                Button( action : { pickerStyle = .dateRange }) { Text(PickerStyle.dateRange.rawValue)}
            }
            
            Text("\(formatDate(selectedDate))")
                .padding(20)
            
            switch pickerStyle {
                case .dateOnly:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .date)
                case .hourAndMinute:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .hourAndMinute)
                case .graphical:
                    DatePicker("Prompt Text", selection: $selectedDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                case .dateRange:
                    DatePicker("Prompt Text", selection: $selectedDate, in: pickerDateRange)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                case .wheel:
                    DatePicker("Prompt Text", selection: $selectedDate)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                case .wheelTimeOnly:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                case .wheelWithLabel:
                    DatePicker("Prompt Text", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                case .wheelWithBorder:
                    DatePicker("Prompt Text", selection: $selectedDate)
                        .datePickerStyle(WheelDatePickerStyle())
                        .background(
                            RoundedRectangle(cornerRadius: 30).stroke(Color.purple, lineWidth: 3)
                        )
                        .foregroundColor(Color.purple)
                        .labelsHidden()
                    
                case .historicalDaysOnly:
                    DatePicker("Prompt Text", selection: $selectedDate, in: ...Date())
                        .datePickerStyle(GraphicalDatePickerStyle())
                case .futureDaysOnly:
                    DatePicker("Prompt Text", selection: $selectedDate, in: Date()...)
                        .datePickerStyle(GraphicalDatePickerStyle())
                case .customColors:
                    DatePicker("Prompt Text", selection: $selectedDate)
                        .accentColor(.purple)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.purple)
                                        .opacity(0.2)
                                        .shadow(radius: 1, x: 4, y: 4))
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(20)
                default:
                    DatePicker("Prompt Text", selection: $selectedDate)
            }
        }.padding(30)
    }
    
    func formatDate(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            ContentView()
        }
    }
}
