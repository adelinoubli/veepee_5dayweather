//
//  Date.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import UIKit

enum DateFormat: String {
    case dayMonthYear = "dd MMM. yyyy"
    case hourAMPM = "h a"
    case day = "dd"
    
    // Add more date formats as needed
}
extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func relativeTime() -> String {
            let calendar = Calendar.current
            let now = Date()

            let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear, .month, .year], from: self, to: now)

            let timeUnits: [(Calendar.Component, String)] = [
                (.year, "year"),
                (.month, "month"),
                (.weekOfYear, "week"),
                (.day, "day"),
                (.hour, "hour"),
                (.minute, "minute"),
                (.second, "second")
            ]

            for unit in timeUnits {
                if let value = components.value(for: unit.0), value > 0 {
                    return "\(value) \(unit.1)\(value > 1 ? "s" : "") ago"
                }
            }

            return "Just now"
        }
    
    func relativeFormat() -> String {
            let formatter = DateFormatter()
            formatter.doesRelativeDateFormatting = true

            if Calendar.current.isDateInToday(self) {
                formatter.dateStyle = .none
                formatter.timeStyle = .short
            } else {
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
            }

            return formatter.string(from: self)
        }
}

extension Int {
    func toDateFormattedString(format: DateFormat = .dayMonthYear) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date.toString(format: format.rawValue)
    }
    
    func getRelativeDay() -> String {
        let calendar = Calendar.current
        let now = Date()

        let date = Date(timeIntervalSince1970: TimeInterval(self))

        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
    }
}
