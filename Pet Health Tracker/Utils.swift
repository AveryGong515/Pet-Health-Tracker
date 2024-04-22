//
//  Utils.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-21.
//

import Foundation
import UIKit

struct Utils {
    
    static let defaults = UserDefaults.standard
    
    static func formatDateTimetoString(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    
    
    
    
}

enum LogType: String {
    case symptom = "symptom"
    case medication = "medication"
    case vaccination = "vaccination"
}

enum DosageUnit: String {
    case mL = "mL"
    case mg = "mg"
}

enum Severity: String {
    case none = "None"
    case mild = "Mild"
    case moderate = "Moderate"
    case severe = "Severe"
}



