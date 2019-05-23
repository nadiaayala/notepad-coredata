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
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
       
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notesArray: [Note] = [Note]()

    override func viewDidLoad() {
        
        //To open the database
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        loadItems()
    }
    
    
    
    
    //MARK: - TableView methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        let note = notesArray[indexPath.row]
        
        cell.textLabel?.text = note.title
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.lightGray
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            let deletedItem = self.notesArray[indexPath.row].title
            self.notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(self.notesArray)
            //            self.saveItems()
            self.deleteNote(noteToDelete: deletedItem!)
        }
        
        return [delete]
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteNote(noteToDelete: notesArray[indexPath.row].title!)
            self.notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.loadItems()
        }
       }
    
    
    //MARK: - PERFORM SEGUE
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNote", sender: "self")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ShowNoteViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedNote = self.notesArray[indexPath.row]
            destinationVC.notesArray = notesArray
            destinationVC.indexPathForCell = indexPath.row
            
            
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
    
    
    
    func deleteNote(noteToDelete: String){
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title = %@", noteToDelete)
        
        do {
            let test = try self.context.fetch(fetchRequest)
            
            let objectToDelete = test[0] as NSManagedObject
            context.delete(objectToDelete)
            
            do{
                try context.save()
            }
            catch{
                print("Error: \(error)")
            }
        }
            
        catch {
            print("Error: \(error)")
        }
    }
    
}


    
    





