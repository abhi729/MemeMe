//
//  MemeVc+PickerDelegate.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 08/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
            textFieldAtTop.isUserInteractionEnabled = true
            textFieldAtBottom.isUserInteractionEnabled = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
