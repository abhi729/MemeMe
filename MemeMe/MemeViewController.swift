//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 08/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var textFieldAtTop: UITextField!
    @IBOutlet weak var textFieldAtBottom: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeWidthAttributeName: -3,
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "impact", size: 40)!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField(textFieldAtTop, "TOP")
        setupTextField(textFieldAtBottom, "BOTTOM")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        if let image = memeImageView.image, image != UIImage() {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
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
        textField.isUserInteractionEnabled = false
        textField.delegate = self
    }
    
    func presentPickerController(_ sourceType: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        presentPickerController(.photoLibrary)
    }
    
    @IBAction func takeAPicture(_ sender: Any) {
        presentPickerController(.camera)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = {(_, completed, _, _) in
            if (completed) {
                self.saveMeme()
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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

    func generateMemedImage() -> UIImage {
        
        topToolBar.isHidden = true
        bottomToolBar.isHidden = true
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolBar.isHidden = false
        bottomToolBar.isHidden = false
        
        return memedImage
    }
    
    func saveMeme() {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: textFieldAtTop.text!, bottomText: textFieldAtBottom.text!, originalImage: memeImageView.image!, memedImage: memedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
}

