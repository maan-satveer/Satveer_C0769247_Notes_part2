//
//  NotesViewController.swift
//  Satveer_C0769247_Notes
//
//  Created by MacStudent on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var textview: UITextView!
    var Text_Note : String?
    var text_string : To_do_TableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.text = Text_Note ?? ""
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
          // text_string?.updateText(text: textview.text)
        text_string?.updateText(text: textview.text)
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
