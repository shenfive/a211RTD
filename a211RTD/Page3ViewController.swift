//
//  Page3ViewController.swift
//  a211RTD
//
//  Created by 申潤五 on 2020/12/26.
//

import UIKit

class Page3ViewController: UIViewController {

    @IBOutlet weak var newContent: UITextField!
    @IBOutlet weak var contentTableView: UITableView!
    
    var key = ""
    var nickName = ""
    var subject = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = subject
        print(subject)
    }
    
    @IBAction func sentContent(_ sender: Any) {
    }
    

}
