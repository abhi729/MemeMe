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
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeWidthAttributeName: -3,
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField(textFieldAtTop, "TOP")
        setupTextField(textFieldAtBottom, "BOTTOM")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setupTextField(_ textField: UITextField, _ withText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = withText
        textField.textAlignment = .center
        textField.delegate = self
    }
        
    func presentPickerController(_ forCamera: Bool) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        if !forCamera {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = .camera
        }
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        presentPickerController(false)
    }
    
    @IBAction func takeAPicture(_ sender: Any) {
        presentPickerController(true)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
       
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if textFieldAtBottom.isEditing {
            memeView.transform = CGAffineTransform(translationX: 0, y: -getKeyboardHeight(notification))
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if textFieldAtBottom.isEditing {
            memeView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

}

