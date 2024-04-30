//
//  SymptomListViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import UIKit

class LogListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    
    var pet: Pet!
    
    @IBOutlet weak var logEntriesTableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    var logEntries = [LogEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logEntriesTableView.rowHeight = 100
        logEntriesTableView.delegate = self
        logEntriesTableView.dataSource = self
        
        configure()
        

        // Do any additional setup after loading the view.
    }
    
    func configure(){
        
        navigationBar.title = "\(pet.name): All Logs"
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logEntries.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogEntryCell", for: indexPath) as! LogEntryCell
        let log = logEntries[indexPath.row]
        cell.title.text = log.logTitle
        cell.dateTime.text = Utils.formatDateTimetoString(date: log.timeStamp)
        switch log.logType{
        case LogType.symptom.rawValue:
            cell.logTypeSymbol.setImage(UIImage(systemName: "stethoscope.circle"), for:.normal)
            break
        
        case LogType.medication.rawValue:
            cell.logTypeSymbol.setImage(UIImage(systemName: "pill.circle"), for:.normal)
            break
        case LogType.vaccination.rawValue:
            cell.logTypeSymbol.setImage(UIImage(systemName: "syringe"), for:.normal)
            break
        default:
            print("invalid LogType")
            break
        }
        
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after tapping
        logEntriesTableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogEntryDetailSegue"{
            guard let selectedIndexPath = logEntriesTableView.indexPathForSelectedRow else {return}
            let selectedEntry = logEntries[selectedIndexPath.row]
            guard let logEntryDetailViewController = segue.destination as? LogEntryDetailViewController else {return}
            logEntryDetailViewController.logEntry = selectedEntry
            
        }
        
//        if segue.identifier == "ViewPetProfileSegue" {
//            guard let selectedIndexPath = petListTableView.indexPathForSelectedRow else {return}
//            let selectedPet = petList[selectedIndexPath.row]
//            guard let petProfileViewController = segue.destination as? PetProfileViewController else {return}
//            petProfileViewController.pet = selectedPet
//        }
//        if segue.identifier == "ComposePetSegue"{
//            if let petComposeViewController = segue.destination as? PetComposeViewController {
//                petComposeViewController.onComposePet = { [weak self] pet in
//                    pet.save()
//                    self?.refreshPets()
//                    
//                }
//            }
//        }
       
    }
    
    
    // add swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let logRemoved = self.logEntries[indexPath.row]
            LogEntry.deleteLog(log:logRemoved)
            refreshLogs()
            
        } 
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            print("not yet handled")
        }
    }
    
    func refreshLogs(){
        self.logEntries = LogEntry.getLogEntriesFor(petID: pet.id)
       logEntriesTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        
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
