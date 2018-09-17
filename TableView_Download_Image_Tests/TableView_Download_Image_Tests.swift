//
//  TableView_Download_Image_Tests.swift
//  TableView_Download_Image_Tests
//
//  Created by KAMAL KUMAR BEHERA on 16/09/18.
//  Copyright © 2018 KAMAL KUMAR BEHERA. All rights reserved.
//

import XCTest
@testable import TableView_Download_Image_GCD

class TableView_Download_Image_Tests: XCTestCase {
    
    func testForViewControllerDelegateConfirmation(){
        let viewController  = ViewController()
        
        // Make Confirm for tableview delegate..
        XCTAssert(viewController.conforms(to: UITableViewDelegate.self), "ViewController does not confirms TableView delegate")
    }
    
    func testForViewControllerDatasourceConfirmation(){
        let viewController  = ViewController()
        
        // Make Confirm for tableview DataSource..
        XCTAssert(viewController.conforms(to: UITableViewDataSource.self), "ViewController does not confirms TableView datasource")
    }
    
    func testForInternetConnection() {
        //Make sure internet coinnection is there ..
        XCTAssert(NetworkServices.isConnectedToInternet(), "No Internet Connection")
    }
    
    func testDownloadWebData() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download tableview json data")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        
        // Create a background task to download the web page.
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
            
        }
        // Start the download task.
        dataTask.resume()
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
}

