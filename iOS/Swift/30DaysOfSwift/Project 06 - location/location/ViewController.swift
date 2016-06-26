//
//  ViewController.swift
//  location
//
//  Created by feiyun on 16/4/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    var locationManager : CLLocationManager!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func myLocationBtnDidTouch(sender: AnyObject) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.locationLabel.text = "定位失败：" + error.localizedDescription
        print(error.userInfo)
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMarks, error) in
            if (error != nil)
            {
                self.locationLabel.text = "定位失败：" + error!.localizedDescription
                print(error?.userInfo)
                return
            }
            if (placeMarks?.count > 0)
            {
                self.displayLocationInfo(placeMarks![0])
            }else{
                self.locationLabel.text = "获取位置失败"
            }
        }
    }
    
    func displayLocationInfo(placeMark:CLPlacemark!) -> Void {
        if let containsPlacemark = placeMark {
        let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
        let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
        let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
        let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
        
        self.locationLabel.text = locality! +  postalCode! +  administrativeArea! +  country!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

