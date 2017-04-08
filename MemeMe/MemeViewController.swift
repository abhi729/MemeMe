//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 08/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var textFieldAtTop: UITextField!
    @IBOutlet weak var textFieldAtBottom: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        
    }
    
    @IBAction func takeAPicture(_ sender: Any) {
        
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
       
    }

}

