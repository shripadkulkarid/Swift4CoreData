//
//  ViewController.swift
//  Swift4CoreData
//
//  Created by Apple on 09/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var tableview: UITableView!
    var names:[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        

      title = "The List"
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        
        
        
        
        
        
        
        

    }

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            names = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    @IBAction func addName(_ sender: Any)
    
    {
       
        let alert = UIAlertController(title: "Insert Name", message: "Please Insert Name!", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "SAVE", style: .default){
            
            UIAlertAction in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            //self.names.append(nameToSave)
            self.save(name: nameToSave)
            self.tableview.reloadData()
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addAction(saveAction)
        
        alert.addAction(cancelAction)
        alert.addTextField()
        present(alert, animated: true)

    }
    
    func save (name : String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "name")
        
        
        
        do {
            try managedContext.save()
            names.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let people = names[indexPath.row]
        cell?.textLabel?.text = people.value(forKey: "name") as! String
        
        return cell!
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}







