//
//  PetListViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import UIKit

class PetListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var petListTableView: UITableView!
    
    
   
    
    
    var petList = [Pet]()
    override func viewDidLoad() {
        super.viewDidLoad()
        petListTableView.rowHeight = 150
        petListTableView.dataSource = self
        petListTableView.delegate = self
//        fetchPets()
        

        // Do any additional setup after loading the view.
    }
    
    func fetchPets()->Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDate1 = dateFormatter.date(from: "2018-11-02")!
        let birthDate2 = dateFormatter.date(from: "2021-09-13")!
        let Pet1 = Pet(name: "Oscar", birthDate: birthDate1, species:"Feline", breed: "Domestic Shorthair", sex: "Male", fixed: true, weight: 15.0, medicalConditions:["IBD", "ginginvitis"], profilePicture: nil)
        let Pet2 = Pet(name: "Emily", birthDate: birthDate2, species:"Canine", breed: "Bichon Frise", sex: "Female", fixed: true, weight: 17.0, medicalConditions: [], profilePicture:nil)
        petList.append(Pet1)
        petList.append(Pet2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshPets()
    }
    
    
    
//    @IBAction func didTapAddNewPet(_ sender: Any) {
//        performSegue(withIdentifier: "AddPetSegue", sender: nil)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath) as! PetCell
        let pet = petList[indexPath.row]
        cell.nameLabel.text = pet.name
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.birthDateLabel.text = formatter.string(from: pet.birthDate)
        cell.breedLabel.text = pet.breed
        cell.speciesLabel.text = pet.species
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after tapping
        petListTableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewPetProfileSegue" {
            guard let selectedIndexPath = petListTableView.indexPathForSelectedRow else {return}
            let selectedPet = petList[selectedIndexPath.row]
            guard let petProfileViewController = segue.destination as? PetProfileViewController else {return}
            petProfileViewController.pet = selectedPet
        }
        if segue.identifier == "ComposePetSegue"{
            if let petComposeViewController = segue.destination as? PetComposeViewController {
                petComposeViewController.onComposePet = { [weak self] pet in
                    pet.save()
                    self?.refreshPets()
                    
                }
            }
        }
        else {
            print("bad request")
        }
    }
    
    
    private func refreshPets() {
        // 1.
        var pets = Pet.getPets()
//
        // 2.
        self.petList = pets
//
        petListTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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
