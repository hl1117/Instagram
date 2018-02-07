//
//  ViewController.swift
//  Instagram
//
//  Created by Harika Lingareddy on 2/6/18.
//  Copyright © 2018 Harika Lingareddy. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                self.loginCompleted()
                // display view controller that needs to shown after successful login
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameLabel.text
        //newUser.email = emailLabel.text
        newUser.password = passwordLabel.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.loginButtonClicked(self)
                // manually segue to logged in view
            }
        }
    }
    
//    func loginCompleted(){
//        self.performSegue(withIdentifier: "LoggedInSegue", sender: self)
//    }
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var usernameTextField: UITextField!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
