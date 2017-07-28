//
//  AddPlatformViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/27/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AddPlatformViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var platformListViewModel: PlatformListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platformListViewModel.platformList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlatformViewCell") as! AddPlatformViewCell
        
        cell.platformViewModel = platformListViewModel.platformList[indexPath.row]
        
        return cell
    }

}
