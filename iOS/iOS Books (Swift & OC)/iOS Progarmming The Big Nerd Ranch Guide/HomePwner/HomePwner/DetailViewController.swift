//
//  DetailViewController.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate {

    var item: Item? {
        didSet {
            self.navigationItem.title = item?.itemName
        }
    }
    var dismissBlock: (()->())?
    
    var imagePickerPopover: UIPopoverController?
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var serialNumberField: UITextField!
    
    @IBOutlet weak var valueField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
  
    
    init(newItem isNew: Bool){
        super.init(nibName: nil, bundle: nil)
        if isNew {
            let doneItem = UIBarButtonItem.init(barButtonSystemItem: .Done, target: self, action: #selector(self.save(_:)))
            self.navigationItem.rightBarButtonItem = doneItem
            
            let cancleItem = UIBarButtonItem.init(barButtonSystemItem: .Cancel, target: self, action: #selector(self.cancel(_:)))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
        
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: #selector(self.updateFont), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }
    
    func save(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: dismissBlock)
    }
    
    func cancel(sender: AnyObject) {
        ItemStore.sharedStore.removeItem(self.item!)
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: dismissBlock)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFont() {
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.nameField.font = font;
        self.serialNumberField.font = font;
        self.valueField.font = font;
        self.dateLabel.font = font;
        self.nameField.font = font;
        self.serialNumberField.font = font;
        self.valueField.font = font;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let io = UIApplication.sharedApplication().statusBarOrientation
        self.prepareViewsForOrientation(io)
        
        
        if let item = self.item {
            nameField.text = item.itemName
            serialNumberField.text = item.serialNumber
            valueField.text = String(item.valueInDollars)
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            dateFormatter.timeStyle = .NoStyle
            self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated!)
            
            
            if let itemKey = item.itemKey {
                let imageToDisplay = ImageStore.sharedStore.imageForKey(itemKey)
                self.imageView.image = imageToDisplay
            } else {
                self.imageView.image = nil
            }
            self.updateFont()
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
        
        if imagePickerPopover != nil && self.imagePickerPopover!.popoverVisible {
            imagePickerPopover?.dismissPopoverAnimated(true)
            imagePickerPopover = nil
            return
        }
        
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
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            imagePickerPopover = UIPopoverController.init(contentViewController: imagePicker)
            imagePickerPopover!.presentPopoverFromBarButtonItem(sender as! UIBarButtonItem, permittedArrowDirections: .Any, animated: true)
        } else {
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        self.imagePickerPopover = nil
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            ImageStore.sharedStore.setImage(image, forKey: (self.item?.itemKey)!)
            self.imageView.image = image
            self.item?.setThumbnailFromImage(image)
        }
        if let mediaURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaURL.path!) {
                UISaveVideoAtPathToSavedPhotosAlbum(mediaURL.path!, nil, nil, nil)
                do {
                    try NSFileManager.defaultManager().removeItemAtPath(mediaURL.path!)
                } catch {}
            }
        }
        
        if self.imagePickerPopover != nil {
            self.imagePickerPopover?.dismissPopoverAnimated(true)
            self.imagePickerPopover = nil
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
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
    
    func prepareViewsForOrientation(orientation:UIInterfaceOrientation) {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            return
        }
        if UIInterfaceOrientationIsLandscape(orientation) {
            self.imageView.hidden = true
            self.cameraButton.enabled = false
        } else {
            self.imageView.hidden = false
            self.cameraButton.enabled = true
        }
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.prepareViewsForOrientation(toInterfaceOrientation)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
