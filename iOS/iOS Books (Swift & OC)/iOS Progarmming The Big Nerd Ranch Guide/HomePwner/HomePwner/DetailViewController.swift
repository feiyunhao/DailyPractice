//
//  DetailViewController.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var item: Item? {
        didSet {
            self.navigationItem.title = item?.itemName
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var serialNumberField: UITextField!
    
    @IBOutlet weak var valueField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
  
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let item = self.item {
            nameField.text = item.itemName
            serialNumberField.text = item.serialNumber
            valueField.text = String(item.valueInDollars)
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            dateFormatter.timeStyle = .NoStyle
            self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
            
            let itemKey = item.itemKey
            let imageToDisplay = ImageStore.sharedStore.imageForKey(itemKey)
            self.imageView.image = imageToDisplay
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        
        let item = self.item!
        item.itemName = self.nameField.text!;
        item.serialNumber = self.serialNumberField.text!;
        item.valueInDollars = Int(self.valueField.text!)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func takePicture(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
            imagePicker.cameraOverlayView = UIView(frame: CGRectMake(29,20,20,20))
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        let availableTypes = UIImagePickerController.availableMediaTypesForSourceType(imagePicker.sourceType)
        imagePicker.mediaTypes = availableTypes!
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            ImageStore.sharedStore.setImage(image, forKey: (self.item?.itemKey)!)
            self.imageView.image = image
        }
        if let mediaURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaURL.path!) {
                UISaveVideoAtPathToSavedPhotosAlbum(mediaURL.path!, nil, nil, nil)
                do {
                    try NSFileManager.defaultManager().removeItemAtPath(mediaURL.path!)
                } catch {}
                
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    
}
