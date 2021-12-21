//
//  MapViewSubclass.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/10/21.
//
//
import Foundation
import UIKit
import GoogleMaps

class MapsSubview : GMSMapView, CLLocationManagerDelegate {
    
    var locationServicesEnabled : Bool = false
    var locationController : LocationController?
    let tunisia = (Latitude :  43.651070, Longitude : -79.347015)
    var locationManager = CLLocationManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.isMyLocationEnabled = false
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        self.setupMap()
        
        self.handleFailure()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)

        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 15);
        self.camera = camera

        let marker = GMSMarker(position: center)

        marker.map = self

        locationManager.stopUpdatingLocation()
        
        groomerOnboardingStruct.groomers_location_latitude = userLocation!.coordinate.latitude
        groomerOnboardingStruct.groomers_location_longitude = userLocation!.coordinate.longitude
        
    }

    func setupMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: tunisia.Latitude, longitude: tunisia.Longitude, zoom: 5)
        GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.camera = camera
        self.mapStyle = .none
        self.backgroundColor = coreWhiteColor
    }
    
    //ENABLE LOCATION SERVICES OR ELSE DISMISS THE CONTROLLER
    @objc func handleLocationServicesAuthorization() {
        
        self.locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch self.locationManager.authorizationStatus {
            
            case .authorizedAlways, .authorizedWhenInUse:
                
                self.handleSuccess()
                print("authorizedAlways")

            case .notDetermined, .restricted :
                print("notDetermined")

                self.locationManager.requestWhenInUseAuthorization()

            case .denied:
                print("at denied")
                self.askUserForPermissionsAgain()

            default : print("Hit an unknown state")
                
            }
            
        } else {
            
            self.askUserForPermissionsAgain()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    self.handleSuccess()
                }
            }
        } else {
            self.handleFailure()
        }
    }
    
    func handleSuccess() {
        
        self.alpha = 1.0
        self.isUserInteractionEnabled = true
        self.locationServicesEnabled = true
        self.isMyLocationEnabled = true
        self.locationServicesEnabled = true
        self.locationController?.enableLocationButton.isUserInteractionEnabled = false
        self.locationController?.notNowButton.isUserInteractionEnabled = false
        self.perform(#selector(self.handleNextScreen), with: nil, afterDelay: 1.0)

    }
    
    func handleFailure() {
        self.alpha = 0.5
        self.isUserInteractionEnabled = false
        self.locationServicesEnabled = false
        self.isMyLocationEnabled = false
        self.locationServicesEnabled = false
        self.locationController?.enableLocationButton.isUserInteractionEnabled = true
        self.locationController?.notNowButton.isUserInteractionEnabled = true
    }
    
    @objc func handleNextScreen() {
        self.locationController?.handleNextScreen()
    }
    
    func askUserForPermissionsAgain() {
        
        let activityViewController = UIAlertController(title: "Location Services", message: "Please allow Doggystyle permission to the devices location so we can find nearby Groomers.", preferredStyle: .alert)
        
        let actionOne = UIAlertAction(title: "Cancel", style: .default) { (alert : UIAlertAction) in
            
            self.locationController?.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        
        let actionTwo = UIAlertAction(title: "Enable", style: .default) { (alert : UIAlertAction) in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                
                return
                
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    
                    self.handleSuccess()

                })
            }
        }
        
        activityViewController.addAction(actionOne)
        activityViewController.addAction(actionTwo)
        self.locationController?.present(activityViewController, animated: true, completion: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}



