//
//  ListVC.swift
//  ChatApp
//
//  Created by Rituraj Mishra on 14/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit
import CoreData

class ListVC: UIViewController
{
    var nameArr = [String]()
    var idArr = [UUID]()
    var chosenEmailId: String!
    var image: Data!
    
    
    //MARK: TableView
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.isHidden = false
        return tableView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 224.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        title = "ChatApp💬"
        
        view.addSubview(tableView)
        setupTableView()
        fetchRecords()
        tableView.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTableView()
    {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: -Fetching Records
    private func fetchRecords()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject]
            {
                if !self.chosenEmailId.isEmpty
                {
                    if chosenEmailId != (result.value(forKey: "email") as? String)
                    {
                        if let fn = result.value(forKey: "fname") as? String
                        {
                            if let ln = result.value(forKey: "lname") as? String
                            {
                                self.nameArr.append(fn+" "+ln)
                                if let id = result.value(forKey: "userId") as? UUID
                                {
                                    self.idArr.append(id)
                                }
                            }
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
            
        }catch{
            print("error \(error)")
        }
    }

}


extension ListVC: UITableViewDataSource, UITableViewDelegate
{
    
    //MARK: -TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nameArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell  else { return UITableViewCell()}
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        let stringUUID = idArr[indexPath.row].uuidString
        request.predicate = NSPredicate(format: "userId = %@", stringUUID)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if result.value(forKey: "profilePic") != nil{
                    image =  result.value(forKey: "profilePic") as? Data
                    }else{
                        image = UIImage(named: "default")?.jpegData(compressionQuality: 0.5)
                    }
                }
            }
        }catch{
            print(error)
        }
        
        cell.configure(name: nameArr[indexPath.row], text: "Last message in the chat!", imageName: image)
        
        return cell
    }
    
    
    //MARK: -TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ChatVC()
        vc.title = nameArr[indexPath.row]
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
        vc.navigationItem.leftBarButtonItem?.tintColor = .darkGray
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    //MARK: -Helper functions
    @objc func backButtonPressed()
    {
        navigationController?.popViewController(animated: true)
    }
}
