//
//  Reminder.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-19.
//

import UIKit


struct Reminder: Codable{
    
    var reminderName: String
    var date: Date
    var time: TimeInterval
    var isActive: Bool
    
    
}
