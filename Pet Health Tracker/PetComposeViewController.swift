//
//  PetComposeViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import UIKit

class PetComposeViewController: UIViewController {
    
    
    @IBOutlet weak var profilePicture: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var speciesField: UITextField!
    
    @IBOutlet weak var breedField: UITextField!
    
    @IBOutlet weak var sexToggle: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var isFixedToggle: UISegmentedControl!
    @IBOutlet weak var medicalConditionsField: UITextField!
    
    // define a closure to pass the newly created Pet around, so that it could be used by PetListViewController
    var onComposePet: ((Pet) -> Void)? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightField.keyboardType = .numberPad
        // disables any future date selection for birthDate
        datePicker.maximumDate = Date()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapSavePet(_ sender: Any) {
        // TODO: check if the required fields as filled out
        //1. Ensure required fields are filled out
        guard let name = nameField.text, let species = speciesField.text, !name.isEmpty, !species.isEmpty else {
            presentAlert(title: "Unable to Save", message: "Please fill out all required fields.")
            return
        }
        var breed: String

        if let text = breedField.text, !text.isEmpty {
            breed = text
        } else {
            breed = "Unspecified Breed"
        }
    
        guard let weightEnteredString = weightField.text else {return}
        var weightEntered: Float?
        if !weightEnteredString.isEmpty{
            weightEntered = Float(weightEnteredString)
        }
        else {
            weightEntered = nil
        }
        
        
            
        let newPet = Pet(id: UUID().uuidString, name: nameField!.text ?? "No Name", birthDate: datePicker.date, species: speciesField.text ?? "Unspecied Species", breed: breed, sex: getSelectedSex(), fixed: getSelectedFixed(), weight: weightEntered, medicalConditions: getEnteredMedicalConditions(), profilePicture: nil)

        onComposePet?(newPet)
        dismiss(animated: true)
        
        
    }
    
    
    
    func formatDate(_ date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    
    func getSelectedSex()->String {
        if sexToggle.selectedSegmentIndex == 0 {
            return "Male"
        }
        return "Female"
    }
    
    func getSelectedFixed()->Bool{
        if isFixedToggle.selectedSegmentIndex == 0 {
            return true
        }
        return false
        
    }
    
    func getEnteredMedicalConditions()->[String]{
        if let medicalConditions = medicalConditionsField.text{
            if !medicalConditions.isEmpty{
                return medicalConditions.components(separatedBy: ",")
            }
        }
        return []
    }
        
    
    private func presentAlert(title: String, message: String) {
        // 1.
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        // 2.
        let okAction = UIAlertAction(title: "OK", style: .default)
        // 3.
        alertController.addAction(okAction)
        // 4.
        present(alertController, animated: true)
    }
}
