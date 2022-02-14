//
//  CustomTableViewCell.swift
//  ChatApp
//
//  Created by Rituraj Mishra on 14/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell
{
    static let identifier = "CustomTableViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.tintColor = .darkGray
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize:25,weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    private let userLabelMessage: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize:20,weight: .regular)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 253.0/255.0, green: 224.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(userLabelMessage)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let layout = contentView.layoutMarginsGuide
        let size = layout.layoutFrame.size
        let w = size.width
        let h = size.height
        
        userImageView.frame = CGRect(x: 10, y: 10, width: 90, height: 90)
        usernameLabel.frame = CGRect(x: 110, y: 15, width: w - 120, height: (h-20)/2)
        userLabelMessage.frame = CGRect(x: 110, y: 55, width: w - 120, height: (h-20)/2)
    }
    
    public func configure(name: String,text: String,imageName: Data)
    {
        userImageView.image = UIImage(data: imageName)
        userLabelMessage.text = text
        usernameLabel.text = name
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        userImageView.image = UIImage(systemName: "person")
        userLabelMessage.text = nil
        usernameLabel.text = nil
    }
}
