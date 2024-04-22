//
//  Reminder.swift
//  Reminder Health Tracker
//
//  Created by Avery Gong on 2024-04-19.
//

import UIKit


struct Reminder: Codable{
    
    var pet: Pet
    var title: String
    var description: String
    var dateTime: Date
    var isActive: Bool
    
    let id: String
    
    
    init(id: String, pet: Pet, title: String, description: String, dateTime: Date, isActive: Bool){
        self.id = id
        self.pet = pet
        self.title = title
        self.description = description
        self.dateTime = dateTime
        self.isActive = isActive
    }
}

extension Reminder {
    static var remindersKey: String{
        return "Reminders"
    }


    // Given an array of tasks, encodes them to data and saves to UserDefaults.
    static func save(_ reminders: [Reminder], forKey key: String) {

        // TODO: Save the array of tasks
        let defaults = Utils.defaults
//        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(reminders)
        defaults.set(encodedData, forKey: key)
        
    }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getReminders() -> [Reminder] {
        
        // TODO: Get the array of saved tasks from UserDefaults

        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: Reminder.remindersKey){
                let decodedTasks = try!JSONDecoder().decode([Reminder].self,from: data)
                return decodedTasks
            } else {
                return []
            }
        }
    
    
    

    // Add a new task or update an existing task with the current task.
    func save() {
        // TODO: Save the current task
        var reminders = Reminder.getReminders()
        if let index = reminders.firstIndex(where: {$0.id == self.id}){
            reminders.remove(at: index)
            reminders.insert(self, at: index)
            
        }
        
        else{
            reminders.append(self)
        }
        Reminder.save(reminders, forKey: Reminder.remindersKey)
    }
    
    static func getReminder(_ id: String)->Reminder?{
        let reminders = Reminder.getReminders()
        if let index = reminders.firstIndex(where: { $0.id == id }) {
            return reminders[index]
        }
        return nil
        
    }
    
    
    static func deleteReminder(_ reminder: Reminder) {
        
            var reminders = Reminder.getReminders()
            if let index = reminders.firstIndex(where: { $0.title == reminder.title }) {
                reminders.remove(at: index)
                save(reminders, forKey: remindersKey)
            }
        }
    
   
    
}


