//
//  Pet.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import Foundation
import UIKit

struct Pet: Codable{
    var name: String
    var birthDate: Date
    var species: String
    var breed: String
    var sex: String
    var fixed: Bool
    var weight: Float
    var medicalConditions: [String]
    var profilePicture: URL?
    
}

// some static methods later on used for updating petList
extension Pet {
    static var petsKey: String{
        return "Pets"
    }


    // Given an array of tasks, encodes them to data and saves to UserDefaults.
    static func save(_ pets: [Pet], forKey key: String) {

        // TODO: Save the array of tasks
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(pets)
        defaults.set(encodedData, forKey: key)
        
    }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getPets() -> [Pet] {
        
        // TODO: Get the array of saved tasks from UserDefaults

        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: Pet.petsKey){
                let decodedTasks = try!JSONDecoder().decode([Pet].self,from: data)
                return decodedTasks
            } else {
                return []
            }
        }

    

    // Add a new task or update an existing task with the current task.
    func save() {
        // TODO: Save the current task
        var pets = Pet.getPets()
//        if let index = tasks.firstIndex(where: {$0.id == self.id}){
//            print("after1",tasks.count)
//            tasks.remove(at: index)
//            tasks.insert(self, at: index)
//            
//        }
//        
//        else{
//            print("after2", tasks.count)
         pets.append(self)
//        }
        Pet.save(pets, forKey: Pet.petsKey)
    }
    
    static func deletePet(_ pet: Pet) {
            var pets = Pet.getPets()
            if let index = pets.firstIndex(where: { $0.name == pet.name }) {
                pets.remove(at: index)
                save(pets, forKey: petsKey)
            }
        }
    
}


