//
//  EditorViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 6/5/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class EditorViewController: UIViewController {
    
    var journal: Journal!
    var textGenerator: RichTextGenerator!
    var generatedText: String!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var textEditorWindow: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textGenerator = RichTextGenerator(object: journal)
        generatedText = textGenerator.generateText()
        textEditorWindow.text = generatedText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func backFromEditor(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

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
