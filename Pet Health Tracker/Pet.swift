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
    var weight: Float?
    var medicalConditions: [String]
    var profilePicture: URL?
    // for each pet, the symptom names should be unique
    var symptomLogNames: [String]
    // for each pet, the medication names should be unique
    var medsLogNames: [String]
    // for each pet, the vaccination names should be unique
    var vaccLogNames: [String]

 
    
    let id: String
    
    
    init(id: String, name: String, birthDate: Date, species: String, breed: String, sex: String, fixed: Bool, weight: Float?, medicalConditions: [String], profilePicture: URL?, symptomLogNames: [String] = [], medsLogNames: [String] = [], vaccLogNames: [String] = []){
        self.id = id
        self.name = name
        self.birthDate = birthDate
        self.species = species
        self.breed = breed
        self.sex = sex
        self.fixed = fixed
        self.weight = weight
        self.medicalConditions = medicalConditions
        self.profilePicture = profilePicture
        self.symptomLogNames = symptomLogNames
        self.medsLogNames = medsLogNames
        self.vaccLogNames = vaccLogNames
       
    }
    
    
    
}

// some static methods later on used for updating petList
extension Pet {
    static var petsKey: String{
        return "Pets"
    }


    // Given an array of tasks, encodes them to data and saves to UserDefaults.
    static func save(_ pets: [Pet], forKey key: String) {

        // TODO: Save the array of tasks
//        let defaults = UserDefaults.standard
        let defaults = Utils.defaults
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
    
    
    

    // Add a new task or update an existing pet with the current pet.
    func save() {
        var pets = Pet.getPets()
        if let index = pets.firstIndex(where: {$0.id == self.id}){
            print("index here: \(index)")
            pets.remove(at: index)
            pets.insert(self, at: index)
        }

        else{
            pets.append(self)
        }
        Pet.save(pets, forKey: Pet.petsKey)
    }
    
    static func getPet(_ id: String)->Pet?{
        let pets = Pet.getPets()
        if let index = pets.firstIndex(where: { $0.id == id }) {
            return pets[index]
        }
        return nil
        
    }
    
    static func getPetByName(_ name: String)->Pet?{
        let pets = Pet.getPets()
        if let index = pets.firstIndex(where: { $0.name == name }) {
            return pets[index]
        }
        return nil
        
    }
    
    
    
    
    static func deletePet(_ pet: Pet) {
        
            var pets = Pet.getPets()
            if let index = pets.firstIndex(where: { $0.name == pet.name }) {
                pets.remove(at: index)
                save(pets, forKey: petsKey)
            }
        }
    
   
    
}


