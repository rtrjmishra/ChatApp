//
//  LoginVC.swift
//  ChatApp
//
//  Created by Rituraj Mishra on 14/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit

class LoginVC: UIViewController
{
    var x: Double = 0.0
    var y: Double = 0.0
    
    //MARK: Image View
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Email
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    //MARK: Password
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    //MARK: Login Button
    private let loginButton: UIButton = {
        let button = UIButton.init(type: .roundedRect)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "Times New Roman", size: 35.0)
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 224.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        title = "Login"
        
        
        let layout = view.layoutMarginsGuide
        let size = layout.layoutFrame.size
        x = size.width
        y = size.height
        
        loginButton.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)

        view.addSubview(imageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: (x-(x/3))/2, y: y/10, width: x/3, height: x/3)
        emailField.frame = CGRect(x: 30, y: y/10 + x/3 + 10, width: x-60, height: 55)
        passwordField.frame = CGRect(x: 30, y: y/10 + x/3 + 70, width: x-60, height: 55)
        loginButton.frame = CGRect(x: 30, y: y/10 + x/3 + 135, width: x-60, height: 55)
    }
    
    //MARK: -Helper Functions
    @objc func loginBtnTapped()
    {
        guard let email = emailField.text , let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count>=6 else
        {
            alertUserLoginError()
            return
        }
        
        let rootVC = ListVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        rootVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutPressed))
        rootVC.navigationItem.rightBarButtonItem?.tintColor = .darkGray
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray, NSAttributedString.Key.font:UIFont(name:"Futura", size: 30)!]
        rootVC.chosenEmailId = email
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    func alertUserLoginError()
    {
        let alert = UIAlertController(title: "Oops!", message: "Please enter all information to login", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    
    @objc func logOutPressed()
    {
        dismiss(animated: false, completion: nil)
        dismiss(animated: false, completion: nil)
    }
    
}
