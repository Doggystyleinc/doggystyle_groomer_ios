//
//  FinishProfileSubview.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/23/21.
//

import Foundation
import UIKit
import AVFoundation

class FinishProfileSubview : UIView {
    
    var dashboardController : DashboardController?
    
    var hasViewBeenLaidOut : Bool = false
    
    lazy var finishProfileContainer : UIButton = {
        
        let fpc = UIButton(type: .system)
        fpc.translatesAutoresizingMaskIntoConstraints = false
        fpc.backgroundColor = coreOrangeColor
        fpc.isUserInteractionEnabled = true
        fpc.layer.masksToBounds = true
        fpc.layer.cornerRadius = 20
        fpc.addTarget(self, action: #selector(self.handleProfileContainer), for: .touchUpInside)
        
        return fpc
    }()
    
    let profileImageView : UIImageView = {
        
        let piv = UIImageView()
        piv.translatesAutoresizingMaskIntoConstraints = false
        piv.backgroundColor = coreWhiteColor
        piv.contentMode = .scaleAspectFill
        piv.isUserInteractionEnabled = false
        piv.clipsToBounds = true
        
       return piv
    }()
    
    let headerProfileLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Finish Profile"
        thl.font = UIFont(name: dsHeaderFont, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        return thl
        
    }()
    
    let headerProfileSubLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Let your team and clients know a little about you"
        thl.font = UIFont(name: rubikRegular, size: 14)
        thl.numberOfLines = 3
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        return thl
        
    }()
    
    let introLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Intro to Doggystyle"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var videoControlSubview : VideoControlSubview = {
        
        let vv = VideoControlSubview()
        vv.finishProfileSubview = self
       return vv
        
    }()
    
    lazy var playButton: UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.layer.masksToBounds = true
        cbf.backgroundColor = .clear
        cbf.layer.masksToBounds = false
        cbf.tintColor = coreWhiteColor
        
        let str = String.fontAwesomeIcon(name: .play) + "   Watch Now"
        cbf.setTitleColor(coreWhiteColor, for: .normal)
        
        let attributedStr = NSMutableAttributedString(string: str)
        
        let range1 = NSRange(location: 0, length: 1)
        attributedStr.addAttribute(.font,
                                   value: UIFont.fontAwesome(ofSize: 18, style: .solid),
                                   range: range1)
        
        let range2 = NSRange(location: 1, length: (str as NSString).length - 1)
        attributedStr.addAttribute(.font,
                                   value: UIFont(name: rubikMedium, size: 20)!,
                                   range: range2)
        
        cbf.setAttributedTitle(attributedStr, for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        
        cbf.clipsToBounds = false
        cbf.layer.masksToBounds = false
        cbf.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        cbf.layer.shadowOpacity = 0.05
        cbf.layer.shadowOffset = CGSize(width: 2, height: 3)
        cbf.layer.shadowRadius = 9
        cbf.layer.shouldRasterize = false
        cbf.addTarget(self, action: #selector(self.handleWatchNowButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    var tintCover : UIImageView = {
        
        let tc = UIImageView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.backgroundColor = .clear
        let image = UIImage(named: "tint_cover_purple")?.withRenderingMode(.alwaysOriginal)
        tc.image = image
        tc.contentMode = .scaleAspectFill
        
       return tc
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreBackgroundWhite
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addViews()
        self.fillViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.finishProfileContainer)
        
        self.finishProfileContainer.addSubview(self.profileImageView)
        self.finishProfileContainer.addSubview(self.headerProfileLabel)
        self.finishProfileContainer.addSubview(self.headerProfileSubLabel)
        
        self.addSubview(self.introLabel)
        self.addSubview(self.videoControlSubview)
        self.addSubview(self.tintCover)
        self.addSubview(self.playButton)

        self.finishProfileContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.finishProfileContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.finishProfileContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.finishProfileContainer.heightAnchor.constraint(equalToConstant: 153).isActive = true
        
        self.profileImageView.centerYAnchor .constraint(equalTo: self.finishProfileContainer.centerYAnchor, constant: 0).isActive = true
        self.profileImageView.leftAnchor.constraint(equalTo: self.finishProfileContainer.leftAnchor, constant: 24).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 89).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 89).isActive = true
        self.profileImageView.layer.cornerRadius = 89/2
        
        self.headerProfileLabel.topAnchor.constraint(equalTo: self.profileImageView.topAnchor, constant: 5).isActive = true
        self.headerProfileLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 25).isActive = true
        self.headerProfileLabel.rightAnchor.constraint(equalTo: self.finishProfileContainer.rightAnchor, constant: -25).isActive = true
        self.headerProfileLabel.sizeToFit()
        
        self.headerProfileSubLabel.topAnchor.constraint(equalTo: self.headerProfileLabel.bottomAnchor, constant: 8).isActive = true
        self.headerProfileSubLabel.leftAnchor.constraint(equalTo: self.headerProfileLabel.leftAnchor, constant: 0).isActive = true
        self.headerProfileSubLabel.rightAnchor.constraint(equalTo: self.finishProfileContainer.rightAnchor, constant: -25).isActive = true
        self.headerProfileSubLabel.sizeToFit()
        
        self.introLabel.topAnchor.constraint(equalTo: self.finishProfileContainer.bottomAnchor, constant: 63).isActive = true
        self.introLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.introLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        self.introLabel.sizeToFit()
        
        self.videoControlSubview.topAnchor.constraint(equalTo: self.introLabel.bottomAnchor, constant: 17).isActive = true
        self.videoControlSubview.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.videoControlSubview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.videoControlSubview.heightAnchor.constraint(equalToConstant: 237).isActive = true
        
        self.playButton.centerXAnchor.constraint(equalTo: self.videoControlSubview.centerXAnchor, constant: 0).isActive = true
        self.playButton.centerYAnchor.constraint(equalTo: self.videoControlSubview.centerYAnchor, constant: 0).isActive = true
        self.playButton.sizeToFit()
        
        self.tintCover.topAnchor.constraint(equalTo: self.introLabel.bottomAnchor, constant: 17).isActive = true
        self.tintCover.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.tintCover.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.tintCover.heightAnchor.constraint(equalToConstant: 237).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.hasViewBeenLaidOut == true {return}
        self.hasViewBeenLaidOut = false
        self.videoControlSubview.initializeVideoPlayerWithVideo()
    }
    
    func fillViews() {
        
        let usersProfilePhotoURL =  groomerUserStruct.profile_image_url ?? "nil"
        self.profileImageView.loadImageGeneralUse(usersProfilePhotoURL) { complete in
            print("IMAGE IS LOADED")
        }
    }
    
    @objc func handleProfileContainer() {
     
        self.dashboardController?.handleCompleteProfilePresentation()
        
    }
    
    @objc func handleWatchNowButton() {
        self.playButton.isHidden = true
        self.videoControlSubview.handlePlayButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
