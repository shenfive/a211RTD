//
//  Page2ViewController.swift
//  a211RTD
//
//  Created by 申潤五 on 2020/12/26.
//

import UIKit

class Page2ViewController: UIViewController,UITableViewDataSource {

    

    

    
    @IBOutlet weak var subjectTable: UITableView!
    var nickName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("page2 NickName:\(nickName)")
        subjectTable.dataSource = self
    }
    

    //MARK: tableViewDelegate DataSource
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell") as! SubjectTableViewCell
        return cell
    }


}
