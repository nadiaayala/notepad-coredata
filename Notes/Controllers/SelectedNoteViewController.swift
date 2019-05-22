//
//  SelectedNoteViewController.swift
//  Notes
//
//  Created by Nadia Ayala on 22/05/19.
//  Copyright © 2019 Nadia Ayala. All rights reserved.
//

import CoreData
import UIKit

class SelectedNoteViewController: UIViewController {
    
    var note = ""
    
    var selectedNote: Note? {
        //Everything insid didSet will happen as soon as the variable gets set with a value
        didSet{
            note = (selectedNote?.title)!
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadItems(note: note)
    }
    
    func loadItems(note: String){
        textView?.text = note
        
    }
}


