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
        
        
        
        
    }


}

