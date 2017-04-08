//
//  SentMemeTabularViewController.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 09/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class SentMemeTabularViewController: UIViewController, UITableViewDataSource {
    
    let cellReuseIdentifier = "memeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UITableViewDataSource delegate functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        return cell
    }
}
