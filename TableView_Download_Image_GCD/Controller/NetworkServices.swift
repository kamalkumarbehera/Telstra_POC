//
//  NetworkServices.swift
//  TableView_Download_Image_GCD
//
//  Created by Deepak Pillai on 14/09/18.
//  Copyright © 2018 KAMAL KUMAR BEHERA. All rights reserved.
//

import UIKit
import Alamofire

class NetworkServices: NSObject {
    
    //Checking internet is connected or not..
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable 
    }
    
    //Fetch and load all data model with also fetch title of the tableview..
    class func loadNetworkData(success:@escaping(_ data:[DataModel], _ data:String)->Void){
        
        var model: [DataModel] = [DataModel]()
        let session: URLSession = URLSession.shared
        var task:URLSessionDownloadTask = URLSessionDownloadTask()
        let url:URL! = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        
        //Internet connection is present ..
        if isConnectedToInternet(){
            task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
                if location != nil{
                    let data:Data! = try? Data(contentsOf: location!)
                    let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                    let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8)
                    do{
                        let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format!)
                        let dict1 = responseJSONDict as? NSDictionary
                        let titleStr = dict1!["title"] as! String //Tableview title fetching from JSON
                        if let row = (dict1 as AnyObject).value(forKey : "rows") as? [AnyObject]{
                            for dict in row{
                                model.append(DataModel(title: dict["title"] as? String, description: dict["description"] as? String, imageName: dict["imageHref"] as? String))
                            }
                            success(model,titleStr)
                        }
                        
                    }catch let error as NSError {
                        print(error)
                    }
                }
            })
            task.resume()
        }else { //No Internet Connection..
            var topController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            while ((topController.presentedViewController) != nil) {
                topController = topController.presentedViewController!;
            }
            
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            topController.present(alert, animated:true, completion:nil)
        }
    
    }
}
