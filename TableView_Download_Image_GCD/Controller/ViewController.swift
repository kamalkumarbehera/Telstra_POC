//
//  ViewController.swift
//  TableView_Download_Image_GCD
//
//  Created by KAMAL KUMAR BEHERA on 11/09/18.
//  Copyright © 2018 KAMAL KUMAR BEHERA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableViewTitle = ""
    var refreshCtrl: UIRefreshControl!
    var cache: NSCache<AnyObject, AnyObject>!
    var contacts: [DataModel] = [DataModel]()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(ViewController.refreshTabeview), for: .valueChanged)
        self.tableView.refreshControl = self.refreshCtrl
        self.cache = NSCache()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell") //register the cell to the table view
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.getAllJsonData()
        self.setUpNavigation()
        
    }

    //Get all json data...
    func getAllJsonData(){
        
        NetworkServices.loadNetworkData { (arrayObjectes,title) in
            weak var weakSelf = self
            weakSelf?.contacts = arrayObjectes
            weakSelf?.tableViewTitle = title
            DispatchQueue.main.async {
                
                weakSelf?.tableView.reloadData()
            }
        }
    }
    
    //Pull-to-refresh to a tableview..
    @objc func refreshTabeview(){
        weak var weakSelf = self
        self.getAllJsonData()
        DispatchQueue.main.async(execute: { () -> Void in
            
            weakSelf?.tableView.refreshControl?.endRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Set the Navigation..
    func setUpNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        navigationItem.title = self.tableViewTitle
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let dictionary = contacts[indexPath.row]
        cell.contact = contacts[indexPath.row]
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            // Use cache
            print("Cached image used, no need to download it")
            cell.imageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }else{
            let artworkUrl = dictionary.imageName
            if artworkUrl != nil{
                let url:URL! = URL(string: artworkUrl!)
                cell.imageView?.sd_setHighlightedImage(with: url, options: .avoidAutoSetImage, completed: { (image, err, cache, url) in
                    
                    if err == nil{
                        cell.imageView?.image = image
                        let itemSize = CGSize.init(width: 50, height: 50)
                        cell.imageView?.clipsToBounds = true
                        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale);
                        let imageRect = CGRect.init(origin: CGPoint.zero, size: itemSize)
                        cell.imageView?.image!.draw(in: imageRect)
                        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!;
                        UIGraphicsEndImageContext();
                    }
                })
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }


}

