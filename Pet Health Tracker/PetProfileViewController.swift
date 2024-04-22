//
//  PetProfileViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import UIKit
//TODO: import Nuke

class PetProfileViewController: UIViewController {
    var pet: Pet!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UITextField!
    @IBOutlet weak var breedLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var sexLabel: UITextField!
    @IBOutlet weak var fixedLabel: UITextField!
    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet weak var medicalConditionsLabel: UITextField!
    @IBOutlet weak var birthDateLabel: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pet.name)
        self.configure(pet: pet)

        // Do any additional setup after loading the view.
    }
    
    func configure(pet: Pet)->Void {
        nameLabel.text = pet.name
        speciesLabel.text = pet.species
        breedLabel.text = pet.breed
        sexLabel.text = pet.sex
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthDateLabel.text = "DOB: \(formatter.string(from: pet.birthDate))"
        ageLabel.text = calculateAge(birthDate: pet.birthDate)
        if pet.fixed{
            fixedLabel.text = "Fixed"
        }
        else {
            fixedLabel.text = "Not Fixed"
        }
        if let weight = pet.weight {
            weightLabel.text = "Weight: \(weight) lbs"
        }
        else{
            weightLabel.text = "Weight: Not Entered"
        }
        
        medicalConditionsLabel.text = "Medical Conditions: \(pet.medicalConditions.joined(separator: ", "))"
//        if let imageURL = pet.profilePicture{
//            Nuke.loadImage(with: imageURL, into: profilePicture)
//        }
        
        
        
        
        
    }
    
    
    func calculateAge(birthDate: Date) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
//        
//        let dateInterval = DateInterval(start: birthDate, end: currentDate)
        let ageComponents = calendar.dateComponents([.year, .month, .day], from: birthDate, to: currentDate)
            let years = ageComponents.year ?? 0
            let months = ageComponents.month ?? 0
            let days = ageComponents.day ?? 0
            
        if years == 0 && months == 0 && days == 0{
            return "Newborn :)"
        }
        return "Age: \(years) yr, \(months) mo, \(days) d"
        
    
    }
    
    

    @IBAction func didTapLogSymptoms(_ sender: Any) {
    }
    @IBAction func didTapSeeAllLogs(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
