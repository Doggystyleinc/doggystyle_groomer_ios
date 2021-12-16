//
//  ChatMediaFeeder.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/13/21.
//

import Foundation
import UIKit
import Firebase

class ChatMediaFeeder : UICollectionViewCell {
    
    var chatCollectionView : ChatCollectionView?
    
    var chatObjectArray : ChatSupportModel? {
        
        didSet {
            
            let users_profile_image_url = chatObjectArray?.users_profile_image_url ?? "nil"
            if let users_selected_image_url = chatObjectArray?.users_selected_image_url {
                if let _ = chatObjectArray?.image_height {
                    if let _ = chatObjectArray?.image_width {
                        if let time_stamp = chatObjectArray?.time_stamp {
                            
                            let convertedDate = Date(timeIntervalSince1970: time_stamp).timePassed()
                            self.timeLabel.text = "\(convertedDate)"
                            
                            //MARK: - PROFILE PHOTO LOAD
                            if users_profile_image_url != "nil" {
                                let imageView = UIImageView()
                                imageView.loadImageGeneralUse(users_profile_image_url) { complete in
                                    guard let image = imageView.image else {return}
                                    self.profilePhoto.setBackgroundImage(image, for: .normal)
                                }
                                
                            } else {
                                
                                self.profilePhoto.titleLabel?.font = UIFont.fontAwesome(ofSize: 15, style: .solid)
                                self.profilePhoto.setTitle(String.fontAwesomeIcon(name: .dog), for: .normal)
                                self.profilePhoto.setTitleColor(coreWhiteColor, for: .normal)
                            }
                            
                            self.portraitImageView.isHidden = false
                            self.landscapeImageView.isHidden = true
                            self.squareImageView.isHidden = true
                            
                            //MARK: - LOAD MAIN IMAGE INTO A UIBUTTON
                            let imageView = UIImageView()
                            imageView.loadImageGeneralUse(users_selected_image_url) { complete in
                                if let image = imageView.image {
                                    self.portraitImageView.imageView?.contentMode = .scaleAspectFill
                                    self.portraitImageView.setImage(image, for: .normal)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var containerView : UIView = {
        
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        
        return cv
        
    }()
    
    let profilePhoto : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = lightGrey
        dcl.contentMode = .scaleAspectFill
        dcl.layer.masksToBounds = true
        
        return dcl
    }()
    
    //MARK: 4:5 RATIO FOR SCALING
    lazy var portraitImageView : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        dcl.imageView?.contentMode = .scaleAspectFit
        dcl.clipsToBounds = true
        dcl.layer.cornerRadius = 10
        dcl.isUserInteractionEnabled = true
        dcl.addTarget(self, action: #selector(self.handleLongimageTouch(sender:)), for: .touchUpInside)
        
        return dcl
    }()
    
    //MARK: 3:2 RATIO FOR SCALING
    let landscapeImageView : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        dcl.contentMode = .scaleAspectFill
        dcl.clipsToBounds = true
        dcl.layer.cornerRadius = 10
        dcl.isUserInteractionEnabled = false
        
        return dcl
    }()
    
    //MARK: 3:2 RATIO FOR SCALING
    let squareImageView : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        dcl.contentMode = .scaleAspectFill
        dcl.clipsToBounds = true
        dcl.layer.cornerRadius = 10
        dcl.isUserInteractionEnabled = false
        
        return dcl
    }()
    
    let timeLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = ""
        thl.font = UIFont(name: rubikRegular, size: 11)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = chatTimeGrey
        thl.backgroundColor = .clear
        
        return thl
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.containerView)
        
        self.containerView.addSubview(self.profilePhoto)
        self.addSubview(self.portraitImageView)
        self.containerView.addSubview(self.landscapeImageView)
        self.containerView.addSubview(self.squareImageView)
        self.containerView.addSubview(self.timeLabel)
        
        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        
        self.profilePhoto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.profilePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.profilePhoto.layer.cornerRadius = 15
        
        self.portraitImageView.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 20).isActive = true
        self.portraitImageView.topAnchor.constraint(equalTo: self.profilePhoto.topAnchor, constant: 0).isActive = true
        self.portraitImageView.heightAnchor.constraint(equalToConstant: 195).isActive = true
        self.portraitImageView.widthAnchor.constraint(equalToConstant: 195).isActive = true
        
        self.landscapeImageView.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 20).isActive = true
        self.landscapeImageView.topAnchor.constraint(equalTo: self.profilePhoto.topAnchor, constant: 0).isActive = true
        self.landscapeImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        self.landscapeImageView.widthAnchor.constraint(equalToConstant: 195).isActive = true
        
        self.squareImageView.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 20).isActive = true
        self.squareImageView.topAnchor.constraint(equalTo: self.profilePhoto.topAnchor, constant: 0).isActive = true
        self.squareImageView.heightAnchor.constraint(equalToConstant: 156).isActive = true
        self.squareImageView.widthAnchor.constraint(equalToConstant: 156).isActive = true
        
        self.timeLabel.rightAnchor.constraint(equalTo: self.portraitImageView.rightAnchor, constant: 0).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        self.timeLabel.sizeToFit()
        
    }
    
    @objc func handleLongimageTouch(sender : UIButton) {
        
        UIDevice.vibrateLight()
        self.chatCollectionView?.handleLongPress(sender : sender)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - PORTRAIT IMAGE
//                                if image_height > image_width {
//
//                                    self.portraitImageView.isHidden = false
//                                    self.landscapeImageView.isHidden = true
//                                    self.squareImageView.isHidden = true
//
//                                    self.portraitImageView.loadImageGeneralUse(users_selected_image_url) { complete in
//                                        print("portrait image has loaded")
//                                    }
//
//                                    //MARK: - LANDSCAPE IMAGE
//                                } else if image_height < image_width {
//
//                                    self.portraitImageView.isHidden = true
//                                    self.landscapeImageView.isHidden = false
//                                    self.squareImageView.isHidden = true
//
//                                    self.landscapeImageView.loadImageGeneralUse(users_selected_image_url) { complete in
//                                        print("portrait image has loaded")
//                                    }
//
//                                    //MARK: - SQUARE IMAGE
//                                } else if image_height == image_width {
//
//                                    self.portraitImageView.isHidden = true
//                                    self.landscapeImageView.isHidden = true
//                                    self.squareImageView.isHidden = false
//
//                                    self.squareImageView.loadImageGeneralUse(users_selected_image_url) { complete in
//                                        print("portrait image has loaded")
//                                    }
//                                }
