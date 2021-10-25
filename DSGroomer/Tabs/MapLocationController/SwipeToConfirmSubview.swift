//
//  SwipeToConfirmSubview.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 10/11/21.
//

class CustomSlider: UISlider {

var trackHeightGrab: CGFloat = 60

//MARK: - KEEP THE COMPONENT CENTERED BY TAKING HALF OFF THE Y ORIGIN
override func trackRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.trackRect(forBounds: bounds)
    rect.size.height = trackHeightGrab
    rect.origin.y -= trackHeightGrab / 2
    return rect
  }
}

import Foundation
import UIKit
import Lottie

class SwipeToConfirmSubview : UIView {
    
    var mapLocationController : MapLocationController?,
        cutTheEndlessLoop : Bool = false
    
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
    
    let checkMarkAnimation : AnimationView = {
        
        let gcm = AnimationView(name: "green_check_anim")
        gcm.backgroundColor = .clear
        gcm.layer.masksToBounds = true
        gcm.translatesAutoresizingMaskIntoConstraints = false
        gcm.loopMode = .playOnce
        gcm.backgroundBehavior = .pauseAndRestore
        gcm.animationSpeed = 1.0
        gcm.isHidden = true
        
        return gcm
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = bellgrey
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        
        self.addViews()
        //MARK: - self.animateLabel() UNCOMMENT FOR LABEL ANIMATION (SLOW FLASH)
        
    }
    
    func addViews() {
        
        self.addSubview(self.slideToConfirmLabel)
        self.addSubview(self.slideMeButton)
        self.addSubview(self.checkMarkAnimation)
        
        self.slideMeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.slideMeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.slideMeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.slideMeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.slideToConfirmLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.slideToConfirmLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 80).isActive = true
        self.slideToConfirmLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -80).isActive = true
        self.slideToConfirmLabel.sizeToFit()
        
        self.checkMarkAnimation.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.checkMarkAnimation.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.checkMarkAnimation.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.checkMarkAnimation.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    //MARK: ANIMATE THE LABEL TO SHOW ACTION IS NECESSARY
    func animateLabel() {
        
        if self.cutTheEndlessLoop == true {return}
        
        UIView.animate(withDuration: 1.0) {
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
    
    //MARK: FOR SLIDER VALUE MAXED OUT - WHICH = CONFIRMATION
    @objc func handleSliderConfirmation(slider : UISlider, event : UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            
            case .ended:
                if slider.value < 1.0 {
                    slider.setValue(0, animated:true)
                    break
                } else {
                    UIDevice.vibrateLight()
                    self.handleConfirmButton()
                    break
                }
                
            default:
                break
            }
        }
    }
    
    @objc func handleConfirmButton() {
        
        self.slideMeButton.isHidden = true
        self.slideToConfirmLabel.isHidden = true
        self.backgroundColor = UIColor .clear
        self.checkMarkAnimation.isHidden = false
        self.animateToCompletion()
        
    }
    
    func animateToCompletion() {
        
        self.checkMarkAnimation.play { isComplete in
            self.checkMarkAnimation.isHidden = true
            self.backgroundColor = bellgrey
            self.slideToConfirmLabel.isHidden = false
            self.slideToConfirmLabel.text = "Confirmed"
            self.cutTheEndlessLoop = true
            self.mapLocationController?.handleSwipeToComplete()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
