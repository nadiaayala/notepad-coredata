//
//  ViewController.swift
//  Notes
//
//  Created by Nadia Ayala on 21/05/19.
//  Copyright © 2019 Nadia Ayala. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController:  UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notesArray: [Note] = [Note]()

    override func viewDidLoad() {
        
        //To open the database
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        super.viewDidLoad()
        
        loadItems()
        
    }
    
    //MARK: - TableView methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        let note = notesArray[indexPath.row]
        
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        
        performSegue(withIdentifier: "goToSelectedNote", sender: "self")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! SelectedNoteViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedNote = self.notesArray[indexPath.row]
            
        }
        
    }
    
    
    //MARK: - Add new notes
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "Add item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                let newItem = Note(context: self.context)
                newItem.title = textField.text!
                self.notesArray.append(newItem)
                self.saveItems()
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(cancelAction)
        alertController.addAction(action)
        
        alertController.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: - Manage data
    
    
    func saveItems(){
        
        
        do {
            try self.context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        print(notesArray)
        
    }
    
    
    func loadItems(){
        
        
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        
      
        
        do{
            //The output for this method will be an array of Items that is stored in our persistent container
            notesArray =  try context.fetch(request)
        }
        catch{
            print("Error fetching data from context. \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    
    }


    
    




