//
//  EditProfileViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-29.
//

import UIKit

class EditProfileViewController: ViewController {
    
    var pet: Pet!
    var editingField: String?
    
   
   
    
    
    @IBOutlet weak var chooseEditFieldButton: UIButton!
    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var editFieldNewValue: UITextField!
    
    var onEditProfile: ((Pet) -> Void)? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()

        // Do any additional setup after loading the view.
    }
    
    private func configure(){
        chooseEditFieldButton.titleLabel?.font = UIFont(name: "AmericanTypewriter", size:14)
        chooseEditFieldButton.addAction(UIAction(title: "", handler: {(_) in print("field selection")}), for: .touchDown)
        chooseEditFieldButton.menu = createEditProfileMenu()
    }
    
//    private func chooseFieldButton(field: UIAction){
//        switch(field.title){
//            case "Name":
//                instruction.text = "Enter new name for your pet:"
//                chooseEditFieldButton.setTitle("Editing Pet Name...", for: .normal)
//                editFieldNewValue.placeholder = "new name ..."
//                break
//            case "Weight":
//                instruction.text = "Enter new weight for your pet in lbs:"
//                chooseEditFieldButton.setTitle("Editing Pet Weight...", for: .normal)
//                editFieldNewValue.placeholder = "new weight in lbs ..."
//                break
//            default:
//                break
//            
//        }
//    }
    
    private func chooseName(field: UIAction){
        instruction.text = "Enter new name for your pet:"
        chooseEditFieldButton.setTitle("Editing Pet Name...", for: .normal)
        editFieldNewValue.placeholder = "new name ..."
        editingField = "Name"
    }
    
    private func chooseWeight(field: UIAction){
        instruction.text = "Enter new weight for your pet in lbs:"
        chooseEditFieldButton.setTitle("Editing Pet Weight...", for: .normal)
        editFieldNewValue.placeholder = "new weight in lbs ..."
        editingField = "Weight"
    }
    
    
    private func createEditProfileMenu()->UIMenu{
        let editNameOption = UIAction(title: "Name", handler: chooseName)
        let editWeightOption = UIAction(title: "Weight", handler: chooseWeight)
        return UIMenu(title: "Choose Property To Edit", options:[.displayInline,.singleSelection], children: [editNameOption, editWeightOption])

    
    }
    
    
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        if let field = editingField, let editField = editFieldNewValue.text, !editField.isEmpty{
            
            if field == "Name"{
                pet.name = editField
                pet.save()
                Pet.save(Pet.getPets(), forKey: Pet.petsKey)
                onEditProfile?(pet)
                dismiss(animated: true)
                
            }
            else if field == "Weight"{
                pet.weight = Utils.stringToFloat(str: editField)
                pet.save()
                Pet.save(Pet.getPets(), forKey: Pet.petsKey)
                onEditProfile?(pet)
                dismiss(animated: true)
                
    
            }
            else {
                presentAlert(title: "Cannot update pet profile!", message: "Please make sure to fill in the required field.")
            }
        }
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
