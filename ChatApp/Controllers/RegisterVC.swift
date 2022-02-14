//
//  RegisterVC.swift
//  ChatApp
//
//  Created by Rituraj Mishra on 14/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit
import CoreData

class RegisterVC: UIViewController
{
    var x: Double = 0.0
    var y: Double = 0.0
    
    //MARK: ImageView
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    //MARK: First name
    private let fName: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    //MARK: Last name
    private let lName: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    //MARK: Email
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
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
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    //MARK: Register Button
    private let registerButton: UIButton = {
        let button = UIButton.init(type: .roundedRect)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(red: 190.0/255.0, green: 0.0, blue: 21.0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "Times New Roman", size: 35.0)
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 224.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        title = "Register"
        
        
        let layout = view.layoutMarginsGuide
        let size = layout.layoutFrame.size
        x = size.width
        y = size.height
        
        registerButton.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)

        view.addSubview(imageView)
        imageView.layer.cornerRadius = x/6.0
        view.addSubview(fName)
        view.addSubview(lName)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(gesture)
        
    }
    
    //MARK: -Helper Functions
    @objc func didTapChangeProfilePic()
    {
        presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: (x-(x/3))/2, y: y/10, width: x/3, height: x/3)
        fName.frame = CGRect(x: 30, y: y/10 + x/3 + 10, width: x-60, height: 55)
        lName.frame = CGRect(x: 30, y: y/10 + x/3 + 70, width: x-60, height: 55)
        emailField.frame = CGRect(x: 30, y: y/10 + x/3 + 130, width: x-60, height: 55)
        passwordField.frame = CGRect(x: 30, y: y/10 + x/3 + 190, width: x-60, height: 55)
        registerButton.frame = CGRect(x: 30, y: y/10 + x/3 + 255, width: x-60, height: 55)
    }
    
    
    @objc func registerBtnTapped()
    {
        guard let fn = fName.text, let ln = lName.text, let email = emailField.text , let password = passwordField.text,
              !fn.isEmpty,!ln.isEmpty,
              !email.isEmpty, !password.isEmpty, password.count>=6 else
        {
            alertUserLoginError()
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue(fn, forKey: "fname")
        newUser.setValue(ln, forKey: "lname")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(UUID(), forKey: "userId")
        newUser.setValue(imageView.image!.jpegData(compressionQuality:0.5), forKey: "profilePic")
        
        do{
            try context.save()
        }catch{
            print("Error \(error)")
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
        let alert = UIAlertController(title: "Oops!", message: "Please enter all information to register", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    @objc func logOutPressed()
    {
        dismiss(animated: false, completion: nil)
        dismiss(animated: false, completion: nil)
    }
    
}

//MARK: -Image Picker View Delegate
extension RegisterVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func presentPhotoActionSheet()
    {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a profile picture", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.presentPhotoPicker()
        }))
        
        present(actionSheet,animated: true)
    }
    
    func presentCamera()
    {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func presentPhotoPicker()
    {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        
        self.imageView.image = selectedImage
    }
}
