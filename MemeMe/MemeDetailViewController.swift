//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 09/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeImageView.image = meme.memedImage
    }
}
