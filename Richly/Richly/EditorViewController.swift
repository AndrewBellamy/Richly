//
//  EditorViewController.swift
//  Richly
//
//  Created by Andrew Bellamy : 215240036 on 6/5/17.
//  SIT206 Assignment 2
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class EditorViewController: UIViewController, UITextViewDelegate {
    
    /**
     Initialization variables
    */
    var journal: Journal!
    var textGenerator: RichTextGenerator!
    var generatedText: String!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    /**
     In UI controls, set as variables for programmatic use.
    */
    @IBOutlet weak var textEditorWindow: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEditorWindow.delegate = self
        textGenerator = RichTextGenerator(object: journal)
        generatedText = textGenerator.generateText()
        textEditorWindow.text = generatedText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
        
    /**
     Dismisses the presenting view controller
    */
    @IBAction func backFromEditor(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

    /**
     Sets the entry property to the text in the editor window.
     Saves the journal NSManagedObject in the context.
    */
    @IBAction func publishJournal(_ sender: Any) {
        journal.entry = textEditorWindow.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        performSegue(withIdentifier: "publishJournal", sender: nil)
        editJournal = nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "publishJournal") {
        }
    }
}
