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
    


    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var note = ""
    
    var indexPathToEdit: Int = 0
    
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
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected")
////        setEditing(true, animated: true)
//        print("This cell from the chat list was selected: \(indexPath.row)")
//        indexPathToEdit = indexPath.row
//        print("aaaaa")
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
//
////        let note = notesArray![indexPath.row]
//
//        let note = notesArray?.first(where: {$0.title == self.note} )
//
//        cell.textLabel?.text = note?.title
//
//
//
//        return cell
//
//    }
//
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        print("a")
//
////        if indexPath.section == 0 {
//
//            if (indexPath.row == 0){
//                print("b")
//                return true
////            }
//        }
//        return false
//    }

    
    
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
    
    
    
