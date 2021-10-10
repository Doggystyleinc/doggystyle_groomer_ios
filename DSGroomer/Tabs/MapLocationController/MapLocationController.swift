//
//  MapLocationController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 10/9/21.
//

import Foundation
import UIKit

class MapLocationController : UIViewController {
    
    let headerContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = coreBackgroundWhite
        hc.isUserInteractionEnabled = true
        
       return hc
    }()
    
    let bottomContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = coreBackgroundWhite
        hc.isUserInteractionEnabled = true
        
       return hc
    }()
    
    lazy var notificationIcon : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = true
        dcl.clipsToBounds = false
        dcl.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        dcl.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        dcl.tintColor = bellgrey
        dcl.addTarget(self, action: #selector(self.handleNotificationsController), for: .touchUpInside)
        
        return dcl
    }()
    
    let notificationBubble : UILabel = {
        
        let nb = UILabel()
        nb.backgroundColor = UIColor.red
        nb.translatesAutoresizingMaskIntoConstraints = false
        nb.isUserInteractionEnabled = false
        nb.layer.masksToBounds = true
        nb.font = UIFont(name: dsHeaderFont, size: 11)
        nb.textAlignment = .center
        nb.layer.borderColor = coreWhiteColor.cgColor
        nb.layer.borderWidth = 1.5
        nb.text = "4"
        nb.textColor = coreWhiteColor
        nb.isHidden = true
        
        return nb
    }()
    
    lazy var warningIcon : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .exclamationTriangle), for: .normal)
        cbf.setTitleColor(dsFlatBlack.withAlphaComponent(0.4), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleWarningIcon), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let navigateLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Navigate to location"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let minuteAndMileLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "4 min - 1.1 mi"
        thl.font = UIFont(name: dsHeaderFont, size: 22)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let addressLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Brickhouse Building 132 NE 30th Ave Toronto, ON 66777"
        thl.font = UIFont(name: rubikRegular, size: 18)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let mapView : UIView = {
        
        let mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.backgroundColor = .red
        
       return mv
    }()
    
    lazy var sendButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .paperPlane), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        cbf.layer.masksToBounds = true
        cbf.addTarget(self, action: #selector(self.handleWarningIcon), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let slideToConfirmContainer : UIView = {
        
        let stc = UIView()
        stc.translatesAutoresizingMaskIntoConstraints = false
        stc.backgroundColor = bellgrey
        stc.layer.masksToBounds = true
        stc.clipsToBounds = true
        stc.layer.cornerRadius = 20
        
       return stc
    }()
    
    lazy var slideMeIcon : UIButton = {

        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = true
        cbf.backgroundColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .arrowRight), for: .normal)
        cbf.setTitleColor(coreWhiteColor, for: .normal)
        cbf.layer.masksToBounds = true
        cbf.layer.cornerRadius = 20
        cbf.frame = CGRect(x: 0, y: 0, width: 60, height: 60)

        return cbf

    }()
    
    lazy var slideMeButton : CustomSlider = {
        
        let cbf = CustomSlider()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        let image = UIImage(named: "slider_thumb")?.withRenderingMode(.alwaysOriginal)
        cbf.setThumbImage(image, for: .normal)
        cbf.tintColor = coreOrangeColor
        cbf.minimumTrackTintColor = bellgrey
        cbf.maximumTrackTintColor = .clear
        cbf.addTarget(self, action: #selector(self.handleSliderConfirmation(slider:event:)), for: .valueChanged)

        return cbf
        
    }()
   
    let slideToConfirmLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Slide to confirm arrival"
        thl.font = UIFont(name: dsHeaderFont, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.animateLabel()
        
    }
    
    func addViews() {
        
        //MARK: - HEADER CONTAINER
        self.view.addSubview(self.headerContainer)
        self.headerContainer.addSubview(self.notificationIcon)
        self.headerContainer.addSubview(self.notificationBubble)
        self.headerContainer.addSubview(self.warningIcon)
        self.headerContainer.addSubview(self.navigateLabel)
        
        //MARK: - BOTTOM CONTAINER
        self.view.addSubview(self.bottomContainer)
        
        //MARK: - MAPVIEW CONTAINER
        self.bottomContainer.addSubview(self.mapView)
        self.bottomContainer.addSubview(self.minuteAndMileLabel)
        self.bottomContainer.addSubview(self.addressLabel)
        self.bottomContainer.addSubview(self.sendButton)
        
        //MARK: - SLIDE TO CONFIRM
        self.bottomContainer.addSubview(self.slideToConfirmContainer)
        self.slideToConfirmContainer.addSubview(self.slideToConfirmLabel)
        self.slideToConfirmContainer.addSubview(self.slideMeButton)

        self.headerContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.headerContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.headerContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.headerContainer.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        self.notificationIcon.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 0).isActive = true
        self.notificationIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.notificationIcon.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.notificationIcon.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.notificationBubble.topAnchor.constraint(equalTo: self.notificationIcon.topAnchor, constant: 7).isActive = true
        self.notificationBubble.rightAnchor.constraint(equalTo: self.notificationIcon.rightAnchor, constant: -7).isActive = true
        self.notificationBubble.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.notificationBubble.widthAnchor.constraint(equalToConstant: 23).isActive = true
        self.notificationBubble.layer.cornerRadius = 23/2
        
        self.warningIcon.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 0).isActive = true
        self.warningIcon.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.warningIcon.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.warningIcon.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.navigateLabel.centerYAnchor.constraint(equalTo: self.notificationIcon.centerYAnchor, constant: 0).isActive = true
        self.navigateLabel.leftAnchor.constraint(equalTo: self.warningIcon.rightAnchor, constant: 10).isActive = true
        self.navigateLabel.rightAnchor.constraint(equalTo: self.notificationIcon.leftAnchor, constant: -10).isActive = true
        self.navigateLabel.sizeToFit()
        
        self.bottomContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.bottomContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.bottomContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.bottomContainer.heightAnchor.constraint(equalToConstant: 292).isActive = true
        
        self.mapView.topAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: 0).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.bottomContainer.topAnchor, constant: 0).isActive = true
        self.mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        self.minuteAndMileLabel.topAnchor.constraint(equalTo: self.bottomContainer.topAnchor, constant: 35).isActive = true
        self.minuteAndMileLabel.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 35).isActive = true
        self.minuteAndMileLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        self.minuteAndMileLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.addressLabel.topAnchor.constraint(equalTo: self.minuteAndMileLabel.bottomAnchor, constant: 5).isActive = true
        self.addressLabel.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 35).isActive = true
        self.addressLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        self.addressLabel.sizeToFit()
        
        self.sendButton.centerYAnchor.constraint(equalTo: self.minuteAndMileLabel.centerYAnchor, constant: 0).isActive = true
        self.sendButton.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.sendButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        self.sendButton.widthAnchor.constraint(equalToConstant: 41).isActive = true
        self.sendButton.layer.cornerRadius = 41/2
        
        self.slideToConfirmContainer.bottomAnchor.constraint(equalTo: self.bottomContainer.bottomAnchor, constant: -44).isActive = true
        self.slideToConfirmContainer.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 30).isActive = true
        self.slideToConfirmContainer.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.slideToConfirmContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.slideMeButton.bottomAnchor.constraint(equalTo: self.bottomContainer.bottomAnchor, constant: -44).isActive = true
        self.slideMeButton.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 30).isActive = true
        self.slideMeButton.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.slideMeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.slideToConfirmLabel.centerYAnchor.constraint(equalTo: self.slideToConfirmContainer.centerYAnchor, constant: 0).isActive = true
        self.slideToConfirmLabel.leftAnchor.constraint(equalTo: self.slideToConfirmContainer.leftAnchor, constant: 80).isActive = true
        self.slideToConfirmLabel.rightAnchor.constraint(equalTo: self.slideToConfirmContainer.rightAnchor, constant: -80).isActive = true
        self.slideToConfirmLabel.sizeToFit()
        
        self.slideMeButton.layer.cornerRadius = 20
        
    }
    
    func animateLabel() {
        
        UIView.animate(withDuration: 0.7) {
            self.slideToConfirmLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.slideToConfirmLabel.alpha = 0.0
        
        } completion: { complete in
            UIView.animate(withDuration: 0.7) {
                self.slideToConfirmLabel.alpha = 1.0
                self.slideToConfirmLabel.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)

            } completion: { complete in
                self.animateLabel()
            }
        }
    }
    
    @objc func handleSliderConfirmation(slider : UISlider, event : UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
               switch touchEvent.phase {
               case .began: print("began")
                   // handle drag began
               case .moved: print("moved")
                   // handle drag moved
               case .ended: print("ended")
                if slider.value < 1.0 {
                    slider.setValue(0, animated:true)
                } else {
                    print("Confirmed the slide")
                    UIDevice.vibrateLight()
                    self.handleConfirmArrival()
                }
               
               default:
                   break
          }
       }
    }
    
    @objc func handleConfirmArrival() {
        print("arrived")
    }
    
    
    @objc func handleNotificationsController() {
        print("handleNotificationsController")
    }
    
    @objc func handleWarningIcon() {
        print("handleWarningIcon")
    }
}

class CustomSlider: UISlider {

var trackHeight: CGFloat = 60

override func trackRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.trackRect(forBounds: bounds)
    rect.size.height = trackHeight
    rect.origin.y -= trackHeight / 2
    return rect
  }
}
