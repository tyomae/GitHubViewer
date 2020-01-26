//
//  AuthViewController.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 01/12/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var continueButton: UIButton!
    
    var authInfoChanged: (() -> Void)?
    
    @IBAction func loginButtonToched(_ sender: Any) {
        AuthService.auth(viewController: self, completion: { [weak self] success in
            if success {
                self?.authInfoChanged?()
                self?.dismiss(animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
                alertController.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                let doneAction = UIAlertAction(title: "Done", style: .default)
                alertController.addAction(doneAction)
                self?.present(alertController, animated: true)
            }
        })
    }
    @IBAction func continueButtonToched(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
