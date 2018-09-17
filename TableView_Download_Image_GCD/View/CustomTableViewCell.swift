//
//  CustomTableViewCell.swift
//  TableView_Download_Image_GCD
//
//  Created by KAMAL KUMAR BEHERA on 11/09/18.
//  Copyright © 2018 KAMAL KUMAR BEHERA. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var contact:DataModel? {
        didSet {
            guard let contactItem = contact else {return}
            //TableView title text..
            if let title = contactItem.title {
                titleLabel.text = " \(title) "
            }
            
            //TableView description text..
            if let description = contactItem.description {
                descriptionLabel.text = " \(description) "
            }
        }
    }
    
    //TabelView image view ..
    let tableImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor =  UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func layoutSubviews() {
        super.layoutSubviews()
        tableImageView.frame = CGRect(x: 0, y: 0, width: 55, height: 55)
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        self.contentView.addSubview(tableImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)

        //CustomTableViewCell auto layout constraints
        //Set anchor property for table image view..
        tableImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:0 ).isActive = true
        tableImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
        tableImageView.heightAnchor.constraint(equalToConstant:100).isActive = true
        tableImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        tableImageView.contentMode = .scaleToFill
        tableImageView.clipsToBounds = true
        
        //Set anchor property for table title label..
        titleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.tableImageView.trailingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Set anchor property for table description title lbel..
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.tableImageView.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        descriptionLabel.numberOfLines = 0  //Support for multiline ...
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}
