//
//  ShowNoteViewController.swift
//  Notes
//
//  Created by Nadia Ayala on 22/05/19.
//  Copyright © 2019 Nadia Ayala. All rights reserved.
//

import UIKit
import CoreData

class ShowNoteViewController: UIViewController {
    


    @IBOutlet weak var textView: UITextView!
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var note = ""
    
   
    
//    var noteForCell = String
    
    
    var notesArray: [Note]? {
        //Everything insid didSet will happen as soon as the variable gets set with a value
        didSet{
            print("did set!")
        }
    }
    
    var selectedNote: Note? {
        
            didSet{
                note = (selectedNote?.title)!
                
                }
            }
    
    var indexPathForCell: Int?{
        didSet{
            
            print(indexPathForCell)
        }
    }
    
    override func viewDidLoad() {
        if note == selectedNote?.title!{
            textView.text = note
        }
      
        
        navigationItem.rightBarButtonItem = editButtonItem
      
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if (editing) {
            // User tapped the Edit button, do what you need
            print("ediitng")
            textView.isEditable = true
            textView.becomeFirstResponder()
        } else {
            // User tapped the Done button, do what you need
             print("not ediitng")
            textView.isEditable = false
            textView.resignFirstResponder()
            saveItems()
        }
    }
    


    
    
    func saveItems(){


        do {
            try self.context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        notesArray![indexPathForCell!].title = textView.text
        print(notesArray)
//
    }

    
//    func deleteNote(noteToDelete: String){
//        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
//        fetchRequest.predicate = NSPredicate(format: "title = %@", noteToDelete)
//
//        do {
//            let test = try self.context.fetch(fetchRequest)
//            print(test)
//
//            let objectToDelete = test[0] as NSManagedObject
//            context.delete(objectToDelete)
//
//            do{
//                try context.save()
//            }
//            catch{
//                print("Error: \(error)")
//            }
//        }
//
//        catch {
//            print("Error: \(error)")
//        }
//    }
//
//
//
//    func loadItems(){
//
//
//        let request : NSFetchRequest<Note> = Note.fetchRequest()
//
//
//        do{
//            //The output for this method will be an array of Items that is stored in our persistent container
//            notesArray =  try context.fetch(request)
//        }
//        catch{
//            print("Error fetching data from context. \(error)")
//        }
//
//        tableView.reloadData()
//    }
//}

    
    

}
