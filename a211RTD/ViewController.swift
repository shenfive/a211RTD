//
//  ViewController.swift
//  a211RTD
//
//  Created by 申潤五 on 2020/12/26.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    
    var ref:DatabaseReference!
    
    @IBOutlet weak var nickNameTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        ref = Database.database().reference()
        
        ref.child("appData").child("name").observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value as? String)
        }

        
        ref.child("appData/name").observeSingleEvent(of: .value) { (snapshot) in
            self.title = (snapshot.value as? String) ?? "未啟動"
        }
        
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goPage2":
            let nextVC = segue.destination as? Page2ViewController
            nextVC?.nickName = nickNameTF.text ?? ""
        default:
            break
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let nickName = nickNameTF.text ?? ""
        if nickName.count < 2{
            msg(msg: "暱稱必需大於二個字")
            return
        }
        
        performSegue(withIdentifier: "goPage2", sender: self)
    }
    
}
extension UIViewController{
    func msg(msg:String){
        let alert = UIAlertController(title: "訊息", message: msg, preferredStyle: .alert)
        //        let okBtn = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        let okBtn = UIAlertAction(title: "我知道了", style: .default) { (alert) in
        }
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}


