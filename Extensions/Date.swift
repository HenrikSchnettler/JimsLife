//
//  Date.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 29.01.23.
//

import Foundation

extension Date {
        var startOfDay: Date {
            return Calendar.current.startOfDay(for: self)
        }
    
        var startOfNextDay: Date {
            var components = DateComponents()
            components.day = 1
            
            var nextDay = Calendar.current.date(byAdding: components, to: startOfDay)!
            return Calendar.current.startOfDay(for: nextDay)
        }

        var endOfDay: Date {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }
        
        var startOfWeek: Date {
            Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
        }
        
        var endOfWeek: Date {
            var components = DateComponents()
            components.weekOfYear = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfWeek)!
        }
        
        var startOfMonth: Date {
            let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
            return Calendar.current.date(from: components)!
        }

        var endOfMonth: Date {
            var components = DateComponents()
            components.month = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfMonth)!
        }
}
