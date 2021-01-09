//
//  Page3ViewController.swift
//  a211RTD
//
//  Created by 申潤五 on 2020/12/26.
//



import UIKit
import FirebaseCore
import FirebaseDatabase



class Page3ViewController: UIViewController,UITableViewDataSource {


    @IBOutlet weak var newContent: UITextField!
    @IBOutlet weak var contentTableView: UITableView!
    
    var key = ""
    var nickName = ""
    var subject = ""
    
    var dcData:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        self.title = subject
        print(subject)
        
        let ref = Database.database().reference().child("appData/dc/\(key)")
        
        ref.observe(.value) { (snapshot) in
            self.dcData.removeAll()
            for allContent in snapshot.children{
                
                if let content = allContent as? DataSnapshot{
                    
                    let theContent = content.childSnapshot(forPath: "c").value  as! String
                    let nickname = content.childSnapshot(forPath: "n").value as! String
                    let time = (content.childSnapshot(forPath: "t").value as! Double) / 1000
                    let date = Date(timeIntervalSince1970: time)
                    
                    let formater = DateFormatter()
                    formater.dateFormat = "yy/MM hh:mm:ss"
                    let dateString = formater.string(from: date)
                    
                    let theData = ["content":theContent,"nickName":nickname,"time":time] as! [String:Any]
                    self.dcData.append(theData)
                    print("c:\(theContent)   n:\(nickname)  d:\(date)")
                    
            
                }
       
                self.dcData.sort { (a, b) -> Bool in
                    return (a["time"] as! Double) > (b["time"] as! Double)
                }
                
                
                self.contentTableView.reloadData()
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
    

    //MARK:TableView DataSourct
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dcData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dcCell") as! DCTableViewCell
        cell.name.text = dcData[indexPath.row]["nickName"] as? String
        cell.content.text = dcData[indexPath.row]["content"] as? String
        
    
        let date = Date(timeIntervalSince1970: dcData[indexPath.row]["time"] as! Double)
        
        let formater = DateFormatter()
        formater.dateFormat = "yy/MM hh:mm:ss"
        let dateString = formater.string(from: date)
        
        cell.time.text = dateString
        
        
        return cell
    }
    
    
}
