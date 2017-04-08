//
//  SentMemeGridViewController.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 09/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class SentMemeGridViewController: UIViewController, UICollectionViewDataSource {
    
    let cellReuseIdentifier = "memeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        return cell
    }
}
