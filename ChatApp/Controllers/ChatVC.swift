//
//  ChatVC.swift
//  ChatApp
//
//  Created by Rituraj Mishra on 14/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit
import CoreData

class ChatVC: UIViewController
{
    //MARK: -Images
    let myImageView1: UIImageView =
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "collection")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    let myImageView2: UIImageView =
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "collection")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    let myImageView3: UIImageView =
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "collection")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    let myImageView4: UIImageView =
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "collection")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: -Variables
    
    var iData: Data!
    var idChosen: UUID!
    var imageViewName: UIImageView!
    var imagesData = [Data]()
    var imageViewData = [Int: UIImageView]()
    var x: Double = 0.0
    var y: Double = 0.0
    var i = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 224.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barTintColor = .lightGray
        
        let layout = view.layoutMarginsGuide
        let size = layout.layoutFrame.size
        x = size.width
        y = size.height
        
        view.addSubview(myImageView1)
        view.addSubview(myImageView2)
        view.addSubview(myImageView3)
        view.addSubview(myImageView4)
        
            
        myImageView1.isUserInteractionEnabled = true
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic1))
        gesture1.numberOfTouchesRequired = 1
        myImageView1.addGestureRecognizer(gesture1)
        
        myImageView2.isUserInteractionEnabled = true
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic2))
        gesture2.numberOfTouchesRequired = 1
        myImageView2.addGestureRecognizer(gesture2)

        myImageView3.isUserInteractionEnabled = true
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic3))
        gesture3.numberOfTouchesRequired = 1
        myImageView3.addGestureRecognizer(gesture3)

        myImageView4.isUserInteractionEnabled = true
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic4))
        gesture4.numberOfTouchesRequired = 1
        myImageView4.addGestureRecognizer(gesture4)
        
        imageViewData[1] = myImageView1
        imageViewData[2] = myImageView2
        imageViewData[3] = myImageView3
        imageViewData[4] = myImageView4
        
        loadData()
        
    }

    override func viewDidLayoutSubviews()
    {
        myImageView1.frame = CGRect(x: (x-(x/1.5))/2, y: y/10, width: x/1.5, height: x/2.4)
        myImageView2.frame = CGRect(x: (x-(x/1.5))/2, y: y/10 + x/2.4 + 10, width: x/1.5, height: x/2.4)
        myImageView3.frame = CGRect(x: (x-(x/1.5))/2, y: y/10 + (2 * x/2.4) + 20, width: x/1.5, height: x/2.4)
        myImageView4.frame = CGRect(x: (x-(x/1.5))/2, y: y/10 + (3 * x/2.4) + 30, width: x/1.5, height: x/2.4)
    }
    
    @objc func didTapChangeProfilePic1()
    {
        imageViewName = myImageView1
        presentPhoto()
    }
    @objc func didTapChangeProfilePic2()
    {
        imageViewName = myImageView2
        presentPhoto()
    }
    @objc func didTapChangeProfilePic3()
    {
        imageViewName = myImageView3
        presentPhoto()
    }
    @objc func didTapChangeProfilePic4()
    {
        imageViewName = myImageView4
        presentPhoto()
    }
    
    func loadData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cou")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject]
            {
                if let id = result.value(forKey: "selectedRow") as? UUID
                {
                    if id == idChosen
                    {
                        self.imagesData.append(result.value(forKey: "image") as! Data)
                    }
                }
            }
            
        }catch
        {
            print("error \(error)")
        }
        
        if imagesData != []
        {
            for data in imagesData
            {
                i += 1
                imageViewData[i]?.image = UIImage(data: data)
                
            }
        }
    }
    
}

//MARK: -Photo picker
extension ChatVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func presentPhoto()
    {
        let actionSheet = UIAlertController(title: "Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)

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
        
        imageViewName.image = selectedImage
        self.iData = selectedImage.jpegData(compressionQuality: 0.5)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newCou = NSEntityDescription.insertNewObject(forEntityName: "Cou", into: context)
        newCou.setValue(idChosen, forKey: "selectedRow")
        newCou.setValue(iData, forKey: "image")
        
        do{
            try context.save()
        }catch{
            print("Error \(error)")
        }
    }
}
