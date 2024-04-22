//
//  SymptomListViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import UIKit

class LogListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    
    var pet: Pet!
    
    @IBOutlet weak var symptomListTableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var symptomLogEntries = [LogEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symptomListTableView.delegate = self
        symptomListTableView.dataSource = self
        
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
        return symptomLogEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogEntryCell", for: indexPath) as! LogEntryCell
        let log = symptomLogEntries[indexPath.row]
        return cell
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
