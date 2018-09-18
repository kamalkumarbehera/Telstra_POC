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
    
    func testHasATableView() {
        let viewController  = ViewController()
        // Make Confirm for viewController have tableview ..
        XCTAssertNotNil(viewController.tableView)
    }
    
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
    
    func testForTableViewDataSourceProtocol() {
        let viewController  = ViewController()
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewHeightForRowAtIndexPath (){
    let viewController  = ViewController()
    let expectedHeight = UITableViewAutomaticDimension
    let actualHeight = viewController.tableView.rowHeight
    
        XCTAssertEqual(expectedHeight, actualHeight, "Cell should have \(expectedHeight) height, but they have \(actualHeight)");
    }
        
    func testForInternetConnection() {
        //Make sure internet coinnection is there ..
        XCTAssert(NetworkServices.isConnectedToInternet(), "No Internet Connection")
    }
    
    func testDownloadWebData() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download tableview json data")
        NetworkServices.loadNetworkData {(arrayObjectes,title) in
            if arrayObjectes.count == 0 && title.isEmpty == true {
                // Make sure we downloaded some data.
                XCTAssertNotNil(nil, "No data was downloaded.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
