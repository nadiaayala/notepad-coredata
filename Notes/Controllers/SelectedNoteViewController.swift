////
////  SelectedNoteViewController.swift
////  Notes
////
////  Created by Nadia Ayala on 22/05/19.
////  Copyright © 2019 Nadia Ayala. All rights reserved.
////
//
//import CoreData
//import UIKit
//
//class SelectedNoteViewController: UIViewController {
//
//
//
//
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    var note = ""
//    var oldText: String = ""
//
//    var notesArray: [Note]? {
//        //Everything insid didSet will happen as soon as the variable gets set with a value
//        didSet{
//            print("did set!")
//            print(notesArray)
//        }
//    }
//
//
//    var selectedNote: Note? {
//        //Everything insid didSet will happen as soon as the variable gets set with a value
//        didSet{
//            note = (selectedNote?.title)!
//            oldText = note
//
//        }
//    }
//
//
//    @IBOutlet weak var textView: UITextView!
//
//
//    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
//   }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationItem.rightBarButtonItem = editButtonItem
//
//
//        loadItems(note: note)
//    }
//
//    func loadItems(note: String){
//        textView?.text = note
//
//    }
//
//
//
//    func saveItems(){
//
//
//        do {
//            try self.context.save()
//        }
//        catch{
//            print("Error saving context \(error)")
//        }
//
//
//
//    }
//
//
//
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//
//
//        if (editing) {
//            print("old text: \(oldText)")
//            textView.becomeFirstResponder()
//            self.textView.isEditable = true
//        } else {
//            // user just tapped the Done button (it now says Edit)
//            var newNote = Note()
//            newNote.title = textView.text!
//            print("new text: \(String(describing: newNote.title))")
////            note = newText!
//
//            let noteToDelete: String
//
//            if let noteInArray = notesArray?.first(where: { $0.title == oldText }){
//                let index = notesArray!.firstIndex(of: noteInArray)
//                noteToDelete = noteInArray.title!
////                if (notesArray != nil) {
////                    self.notesArray?.remove(at: index!)
////                    self.deleteNote(noteToDelete: noteToDelete)
////                }
//
//                if (notesArray != nil) {
//                    self.notesArray?.remove(at: index!)
//                    self.notesArray?.append(newNote)
//                    self.deleteNote(noteToDelete: noteToDelete)
//                    self.saveItems()
//                }
//
//            }
//
//
//
//
////            print("ARRAY LENGTH: \(String(describing: notesArray?.count))")
//            print(notesArray)
//
//
//        }
//
//
////            let index = notesArray?.firstIndex(of: noteInArray!)
////            print(index)
////
////            self.notesArray?.remove(at: index!)
////            if let noteInArray = notesArray?.first(where: { $0.title == oldText }) {
////                self.deleteNote(noteToDelete: noteInArray)
////            }
////
////            print(notesArray?.count)
//////            self.deleteNote(noteToDelete: noteInArray!)
////
////
//////            loadItems(note: note)
////
////            textView.resignFirstResponder()
////            self.textView.isEditable = false
//
//    }
//
//
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
//}
//
//
