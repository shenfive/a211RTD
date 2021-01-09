//
//  Page3ViewController.swift
//  a211RTD
//
//  Created by 申潤五 on 2020/12/26.
//



import UIKit
import FirebaseCore
import FirebaseDatabase



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
        
        let ref = Database.database().reference().child("appData/dc/\(key)")
        
        ref.observe(.value) { (snapshot) in
            
            for allContent in snapshot.children{
                if let content = allContent as? DataSnapshot{
                    
                    let theContent = content.childSnapshot(forPath: "c").value  as! String
                    let nickname = content.childSnapshot(forPath: "n").value as! String
                    let time = (content.childSnapshot(forPath: "t").value as! Double) / 1000
                    let date = Date(timeIntervalSince1970: time)
                    print("c:\(theContent)   n:\(nickname)  d:\(date)")
                    
                }
            }
        }
        
        
    }
    
    
    
    @IBAction func sentContent(_ sender: Any) {
        let content = newContent.text ?? ""
        if content.count <= 0 {
            return
        }
        let time = ServerValue.timestamp()
        let dc = ["c":content,"n":nickName,"t":time] as [String : Any]
        let ref = Database.database().reference().child("appData/dc/\(key)")
        ref.childByAutoId().setValue(dc)
        
        
    }
    

}
