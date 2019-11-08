//
//  LoginViewController.swift
//  ios_mvc
//
//  Created by KHURSHIDBEK on 2019/11/08.
//  Copyright © 2019 UHanaro. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }

    // MARK: - Action
    
    @IBAction func loginAction(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        apiLogin(email: email, password: password)
    }
    
    // MARK: - Method
    
    func initViews(){
        
    }
    
    // MARK: - Rest Api
    
    func apiLogin(email:String, password: String){

        AlamHttp.get(url: AlamHttp.API_USER_LOGIN, params: AlamHttp.paramsLogin(email: email, password: password),handler: { response in

            switch response.result {
            case .success:
                let result = try! JSONDecoder().decode(Result.self, from: response.data!)
                self.responseLogin(result: result)
            case .failure(let error):
                self.errorLabel.text = error.localizedDescription
            }
        })
    }
    
    func responseLogin(result: Result){
        if(result == nil){
            return
        }
        
        if(result.status == "0"){
            self.sceneDelegate().callHomeController()
        }else{
            self.errorLabel.text = result.message
        }
    }

}
