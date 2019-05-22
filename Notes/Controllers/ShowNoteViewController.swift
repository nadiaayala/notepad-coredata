//
//  ShowNoteViewController.swift
//  Notes
//
//  Created by Nadia Ayala on 22/05/19.
//  Copyright © 2019 Nadia Ayala. All rights reserved.
//

import UIKit
import CoreData

class ShowNoteViewController: UITableViewController {
    
  
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var note = ""
    
//    var noteForCell = String
    
    
    var notesArray: [Note]? {
        //Everything insid didSet will happen as soon as the variable gets set with a value
        didSet{
            print("did set!")
            print(notesArray)
        }
    }
    
    var selectedNote: Note? {
        
            didSet{
                note = (selectedNote?.title)!
                }
            }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
//        let note = notesArray![indexPath.row]
        
        let note = notesArray?.first(where: {$0.title == self.note} )
        
        cell.textLabel?.text = note?.title
        
       
        
        return cell
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        if editing {
            print("Are we editing NOW: \(isEditing)")
            
            
        } else {
            print("Are we editing: \(isEditing)")
            loadItems()
            
        }
    }
    
    
    func saveItems(){
        
        
        do {
            try self.context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        print(notesArray!)
        
    }
    
    func deleteNote(noteToDelete: String){
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title = %@", noteToDelete)
        
        do {
            let test = try self.context.fetch(fetchRequest)
            print(test)
            
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
