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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
