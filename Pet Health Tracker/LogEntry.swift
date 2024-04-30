//
//  LogEntry.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-22.
//

import Foundation
import UIKit


struct LogEntry: Codable{
    var logTitle: String
    var pet: Pet
    var logType: String
    var timeStamp: Date
    var description: String
    // conditional fields depending on logType
    var severity: String? // symptom logType only
    var frequency: String? // symptom logType only
    var dosage: Float? // medication logType only
    var dosageUnit: String? // medication logType only
    var serialID: String? // Note: this is for vaccination only
    
    let id: String
    
    init(id: String, logTitle: String, pet: Pet, logType: String, timeStamp: Date, description: String,
         severity: String? = nil, frequency: String? = nil, dosage: Float? = nil, dosageUnit: String? = nil, serialID: String? = nil){
        self.id = id
        self.logTitle = logTitle
        self.pet = pet
        self.logType = logType
        self.timeStamp = timeStamp
        self.description = description
        self.severity = severity
        self.frequency = frequency
        self.dosage = dosage
        self.dosageUnit = dosageUnit
        self.serialID = serialID
        
       
    }
    
    
}

extension LogEntry{
    
    //TODO: Implement user default, saving, get logs by name
    static var logEntryKey: String{
        return "LogEntry"
    }


    // Given an array of tasks, encodes them to data and saves to UserDefaults.
    static func save(_ logEntries: [LogEntry], forKey key: String) {

        // TODO: Save the array of tasks
//        let defaults = UserDefaults.standard
        let defaults = Utils.defaults
        let encodedData = try! JSONEncoder().encode(logEntries)
        defaults.set(encodedData, forKey: key)
        
    }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getLogEntries() -> [LogEntry] {
        
        // TODO: Get the array of saved tasks from UserDefaults

        let defaults = Utils.defaults
        if let data = defaults.data(forKey: LogEntry.logEntryKey){
                let decodedTasks = try!JSONDecoder().decode([LogEntry].self,from: data)
                return decodedTasks
            } else {
                return []
            }
        }
    
    
    

    // Add a new task or update an existing pet with the current pet.
    func save() {
        var logEntries = LogEntry.getLogEntries()
        if let index = logEntries.firstIndex(where: {$0.id == self.id}){
            logEntries.remove(at: index)
            logEntries.insert(self, at: index)
        }

        else{
            logEntries.append(self)
        }
        LogEntry.save(logEntries, forKey: LogEntry.logEntryKey)
    }
    
    static func getLogEntriesFor(petID: String)->[LogEntry]{
        let logEntries = LogEntry.getLogEntries()
        let entriesForPet = logEntries.filter { $0.pet.id == petID }
        return entriesForPet
        
    }
    
    static func deleteLog(log: LogEntry){
        var logEntries = LogEntry.getLogEntries()
        if let index = logEntries.firstIndex(where: {$0.id == log.id}){
            logEntries.remove(at: index)
            LogEntry.save(logEntries, forKey: LogEntry.logEntryKey)
        }
    }
    

}









