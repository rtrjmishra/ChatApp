//
//  MainVC.swift
//  ChatApp
//
//  Created by Rituraj Mishra on 13/02/22.
//

import UIKit
import CLTypingLabel

class MainVC: UIViewController
{
    //MARK: -Outlets
    var textLabel: CLTypingLabel!
    var x: Double = 0.0
    var y: Double = 0.0
    
    
    override func viewDidLoad()
    {
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 224.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        
        let layout = view.layoutMarginsGuide
        let size = layout.layoutFrame.size
        x = size.width
        y = size.height
        
        
        //MARK: App's Name
        textLabel = CLTypingLabel()
        textLabel.text = "ChatApp💬"
        textLabel.textColor = .darkGray
        textLabel.font = UIFont(name: "Futura", size: 50.0)
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        
        //MARK: Register Button
        let rButton = UIButton.init(type: .system)
        rButton.setTitle("Register", for: .normal)
        rButton.frame = CGRect(x: 1, y: y/1.2, width: x-2.0, height: 50.0)
        rButton.layer.cornerRadius = 10
        rButton.setTitleColor(.white, for: .normal)
        rButton.layer.borderWidth = 0.1
        rButton.layer.borderColor = UIColor.white.cgColor
        rButton.backgroundColor = UIColor(red: 255.0/255.0,green: 0.0/255.0,blue: 28.0/255.0,alpha: 1.0)
        rButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 35.0)
        rButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        view.addSubview(rButton)
        
        //MARK: Login Button
        let lButton = UIButton.init(type: .system)
        lButton.setTitle("Login", for: .normal)
        lButton.frame = CGRect(x: 4, y: y/1.1, width: x-8.0, height: 50.0)
        lButton.layer.cornerRadius = 10
        lButton.setTitleColor(.darkGray, for: .normal)
        lButton.layer.borderWidth = 0.1
        lButton.layer.borderColor = UIColor.white.cgColor
        lButton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 35.0)
        lButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        view.addSubview(lButton)
    }
    
    //MARK: -Helper Functions
    @objc func registerPressed()
    {
        let rootVC = RegisterVC()
        rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToMainVC))
        rootVC.navigationItem.leftBarButtonItem?.tintColor = .darkGray
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray, NSAttributedString.Key.font:UIFont(name:"Futura", size: 30)!]
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    @objc func loginPressed()
    {
        let rootVC = LoginVC()
        rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToMainVC))
        rootVC.navigationItem.leftBarButtonItem?.tintColor = .darkGray
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray, NSAttributedString.Key.font:UIFont(name:"Futura", size: 30)!]
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    @objc func backToMainVC()
    {
        dismiss(animated: true, completion: nil )
    }

}

