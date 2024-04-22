//
//  Utils.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-21.
//

import Foundation


struct Utils {
    
    static let defaults = UserDefaults.standard
    
    static func formatDateTimetoString(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    
    
}

