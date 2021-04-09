//
//  SuperViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

class SuperViewController: UIViewController {
    var className: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.activeViewController = self
        
        className = NSStringFromClass(appDelegate.activeViewController!.classForCoder).components(separatedBy: ".").last!
        print(className!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
