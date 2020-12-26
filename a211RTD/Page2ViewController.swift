//
//  Page2ViewController.swift
//  a211RTD
//
//  Created by 申潤五 on 2020/12/26.
//

import UIKit
import FirebaseDatabase

class Page2ViewController: UIViewController,UITableViewDataSource {

    

    
    var subjects:[String] = []
    var keys:[String] = []
    var ref:DatabaseReference!
    
    @IBOutlet weak var subjectTable: UITableView!
    var nickName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("page2 NickName:\(nickName)")
        subjectTable.dataSource = self
        ref = Database.database().reference(withPath: "appData/subjects")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { (snapshot) in
            self.subjects.removeAll()
            self.keys.removeAll()
            for subjetItem in snapshot.children{
                if let item = subjetItem as? DataSnapshot{
                    self.subjects.append(item.childSnapshot(forPath: "subject").value  as! String)
                    self.keys.append(item.key)
                }
            }
            self.subjectTable.reloadData()
        }
        
        
        
    }
    
    
    

    //MARK: tableViewDelegate DataSource
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell") as! SubjectTableViewCell
        cell.theSubject.text = subjects[indexPath.row]
        return cell
    }


}
