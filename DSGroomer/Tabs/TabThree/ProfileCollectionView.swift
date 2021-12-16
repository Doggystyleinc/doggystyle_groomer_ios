//
//  ProfileCollectionView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/13/21.
//


import Foundation
import UIKit

class ProfileCollectionSubview : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let profileID = "profileID", profileClockedID = "profileClockedID"
    
    var arrayOfStaticLabels = ["You’re clocked out", "Earnings & Reviews", "Notifications", "Payment Preferences"]
    
    var profileController : ProfileController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.alwaysBounceVertical = true
        self.register(ProfileFeeder.self, forCellWithReuseIdentifier: self.profileID)
        self.register(ProfileClockedFeeder.self, forCellWithReuseIdentifier: self.profileClockedID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        if indexPath.item == 0 {
            if self.profileController?.shouldExpandClockedCell == false {
            return CGSize(width: UIScreen.main.bounds.width / 1.15, height: 70)
            } else {
                return CGSize(width: UIScreen.main.bounds.width / 1.15, height: 126)
            }
        } else {
            return CGSize(width: UIScreen.main.bounds.width / 1.15, height: 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfStaticLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item != 0 {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.profileID, for: indexPath) as! ProfileFeeder
        
        let feederLabels = self.arrayOfStaticLabels[indexPath.item]
        
        cell.profileCollectionSubview = self
        cell.feederLabel.text = feederLabels
        
        switch indexPath.item {
        
        case 0 :
            cell.feederIcon.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
            cell.feederIcon.text = String.fontAwesomeIcon(name: .dog)
            cell.feederIcon.textColor = coreOrangeColor
        case 1 :
            cell.feederIcon.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
            cell.feederIcon.text = String.fontAwesomeIcon(name: .star)
            cell.feederIcon.textColor = coreOrangeColor
        case 2 :
            cell.feederIcon.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
            cell.feederIcon.text = String.fontAwesomeIcon(name: .bell)
            cell.feederIcon.textColor = coreOrangeColor
        case 3 :
            cell.feederIcon.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
            cell.feederIcon.text = String.fontAwesomeIcon(name: .dollarSign)
            cell.feederIcon.textColor = coreOrangeColor
      
        default: print("never hit this")
            
        }
        
        return cell
            
        } else {
            
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.profileClockedID, for: indexPath) as! ProfileClockedFeeder
            
            cell.profileCollectionSubview = self
            
            if self.profileController?.shouldExpandClockedCell == true {
                cell.shouldExpand(should: true)
            } else {
                cell.shouldExpand(should: false)
            }
            
            let feederLabels = self.arrayOfStaticLabels[indexPath.item]
            cell.clockedLabel.text = feederLabels
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    
    @objc func handleSelection(sender: UIButton) {
        
        let selectedButtonCell = sender.superview as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        
        switch indexPath.item {
        
        case 0 : self.profileController?.handleClockInButton()
        case 1 : self.profileController?.handleEarningsAndReviews()
        case 2 : self.profileController?.handleNotificationManagementController()
        case 3 : self.profileController?.handlePaymentPreferences()
      
        default : print("Button not found, add it to the array")
            
        }
    }
    
    func handleClockedButton() {
        
        //MARK: - CHANGE THE BOOLEAN
       if self.profileController?.shouldExpandClockedCell == false {
            self.profileController?.shouldExpandClockedCell = true
        } else {
            self.profileController?.shouldExpandClockedCell = false
        }
        
        let indexpathZero = IndexPath(item: 0, section: 0)
        
        DispatchQueue.main.async {
            self.reloadItems(at: [indexpathZero])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


import Foundation
import UIKit

class ProfileFeeder : UICollectionViewCell {
    
    var profileCollectionSubview : ProfileCollectionSubview?
    
    lazy var mainContainer : UIButton = {
        
        let dc = UIButton(type: .system)
        dc.translatesAutoresizingMaskIntoConstraints = false
        dc.backgroundColor = coreWhiteColor
        dc.isUserInteractionEnabled = true
        dc.clipsToBounds = false
        dc.layer.masksToBounds = false
        dc.layer.shadowColor = coreBlackColor.cgColor
        dc.layer.shadowOpacity = 0.05
        dc.layer.shadowOffset = CGSize(width: 0, height: 0)
        dc.layer.shadowRadius = 8
        dc.layer.shouldRasterize = false
        dc.addTarget(self, action: #selector(self.handleButtonSelection), for: .touchUpInside)
        
        return dc
    }()
    
    let feederIcon : UILabel = {
        
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.textAlignment = .center
        return nl
    }()
    
    let feederLabel : UILabel = {
        
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.font = UIFont(name: rubikRegular, size: 18)
        nl.textColor = coreBlackColor
        nl.textAlignment = .left
        nl.numberOfLines = 1
        nl.adjustsFontSizeToFitWidth = true
        
        return nl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.mainContainer)
        self.addSubview(self.feederIcon)
        self.addSubview(self.feederLabel)
        
        self.mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.mainContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.mainContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.mainContainer.layer.cornerRadius = 15
        
        self.feederIcon.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 17).isActive = true
        self.feederIcon.centerYAnchor.constraint(equalTo: self.mainContainer.centerYAnchor, constant: 0).isActive = true
        self.feederIcon.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.feederIcon.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.feederLabel.leftAnchor.constraint(equalTo: self.feederIcon.rightAnchor, constant: 8).isActive = true
        self.feederLabel.rightAnchor.constraint(equalTo: self.mainContainer.rightAnchor, constant: -12).isActive = true
        self.feederLabel.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        
    }
    
    @objc func handleButtonSelection(sender : UIButton) {
        self.profileCollectionSubview?.handleSelection(sender : sender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProfileClockedFeeder : UICollectionViewCell {
    
    var profileCollectionSubview : ProfileCollectionSubview?
    
    lazy var mainContainer : UIButton = {
        
        let dc = UIButton(type: .system)
        dc.translatesAutoresizingMaskIntoConstraints = false
        dc.backgroundColor = coreOrangeColor
        dc.isUserInteractionEnabled = true
        dc.clipsToBounds = true
        dc.layer.masksToBounds = false
        dc.layer.shadowColor = coreBlackColor.cgColor
        dc.layer.shadowOpacity = 0.05
        dc.layer.shadowOffset = CGSize(width: 0, height: 0)
        dc.layer.shadowRadius = 8
        dc.layer.shouldRasterize = false
        dc.addTarget(self, action: #selector(self.handleButtonSelection), for: .touchUpInside)
        
        return dc
    }()
    
    let clockedLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "You’re clocked out"
        thl.font = UIFont(name: dsHeaderFont, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        thl.backgroundColor = .clear
        return thl
        
    }()
    
    let subContainer : UIView = {
        
        let sc = UIView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.backgroundColor = .clear
        sc.isUserInteractionEnabled = false
        
        return sc
    }()
    
    let leftContainer : UIView = {
        
        let vtv = UIView()
        vtv.backgroundColor = .clear
        vtv.translatesAutoresizingMaskIntoConstraints = false
        vtv.isUserInteractionEnabled = true
        
        return vtv
    }()
    
    let rightContainer : UIView = {
        
        let vtv = UIView()
        vtv.backgroundColor = .clear
        vtv.translatesAutoresizingMaskIntoConstraints = false
        vtv.isUserInteractionEnabled = true
     
        return vtv
    }()
    
    let clockedInLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Clocked In:"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        thl.backgroundColor = .clear
        return thl
        
    }()
    
    let scheduledLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Scheduled:"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        return thl
        
    }()
    
    let clockedInTimeLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "7:00AM"
        thl.font = UIFont(name: rubikBold, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        return thl
        
    }()
    
    let timeFrameLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "7AM-3PM"
        thl.font = UIFont(name: rubikBold, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        return thl
        
    }()
    
    let dividerPipe : UIView = {
        
        let dp = UIView()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.backgroundColor = coreWhiteColor
        dp.layer.masksToBounds = true
        
       return dp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        //MARK: - MAIN CONTAINER
        self.addSubview(self.mainContainer)
        self.mainContainer.addSubview(self.clockedLabel)
        self.mainContainer.addSubview(self.subContainer)
        
        //MARK: - LEFT CONTAINER
        self.subContainer.addSubview(self.leftContainer)
        self.leftContainer.addSubview(self.clockedInLabel)
        self.leftContainer.addSubview(self.clockedInTimeLabel)
        
        //MARK: - RIGHT CONTAINER
        self.subContainer.addSubview(self.rightContainer)
        self.rightContainer.addSubview(self.scheduledLabel)
        self.rightContainer.addSubview(self.timeFrameLabel)

        self.subContainer.addSubview(self.dividerPipe)

        self.mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.mainContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.mainContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.mainContainer.layer.cornerRadius = 15
        
        self.clockedLabel.topAnchor.constraint(equalTo: self.mainContainer.topAnchor, constant: 17).isActive = true
        self.clockedLabel.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 30).isActive = true
        self.clockedLabel.rightAnchor.constraint(equalTo: self.mainContainer.rightAnchor, constant: -30).isActive = true
        self.clockedLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.subContainer.topAnchor.constraint(equalTo: self.clockedLabel.bottomAnchor, constant: 20).isActive = true
        self.subContainer.bottomAnchor.constraint(equalTo: self.mainContainer.bottomAnchor, constant: 0).isActive = true
        self.subContainer.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 0).isActive = true
        self.subContainer.rightAnchor.constraint(equalTo: self.mainContainer.rightAnchor, constant: 0).isActive = true
        
        self.leftContainer.topAnchor.constraint(equalTo: self.subContainer.topAnchor, constant: 0).isActive = true
        self.leftContainer.leftAnchor.constraint(equalTo: self.subContainer.leftAnchor, constant: 0).isActive = true
        self.leftContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.leftContainer.rightAnchor.constraint(equalTo: self.subContainer.centerXAnchor).isActive = true
        
        self.rightContainer.topAnchor.constraint(equalTo: self.subContainer.topAnchor, constant: 0).isActive = true
        self.rightContainer.rightAnchor.constraint(equalTo: self.subContainer.rightAnchor, constant: 0).isActive = true
        self.rightContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.rightContainer.leftAnchor.constraint(equalTo: self.subContainer.centerXAnchor).isActive = true
        
        self.dividerPipe.topAnchor.constraint(equalTo: self.subContainer.topAnchor, constant: 5).isActive = true
        self.dividerPipe.bottomAnchor.constraint(equalTo: self.subContainer.bottomAnchor, constant: -5).isActive = true
        self.dividerPipe.centerXAnchor.constraint(equalTo: self.subContainer.centerXAnchor).isActive = true
        self.dividerPipe.widthAnchor.constraint(equalToConstant: 2).isActive = true
        self.dividerPipe.layer.cornerRadius = 1
        
        self.clockedInLabel.centerYAnchor.constraint(equalTo: self.leftContainer.centerYAnchor, constant: -15).isActive = true
        self.clockedInLabel.leftAnchor.constraint(equalTo: self.leftContainer.leftAnchor, constant: 10).isActive = true
        self.clockedInLabel.rightAnchor.constraint(equalTo: self.leftContainer.rightAnchor, constant: -10).isActive = true
        self.clockedInLabel.sizeToFit()
        
        self.clockedInTimeLabel.topAnchor.constraint(equalTo: self.clockedInLabel.bottomAnchor, constant: 6).isActive = true
        self.clockedInTimeLabel.leftAnchor.constraint(equalTo: self.leftContainer.leftAnchor, constant: 10).isActive = true
        self.clockedInTimeLabel.rightAnchor.constraint(equalTo: self.leftContainer.rightAnchor, constant: -10).isActive = true
        self.clockedInTimeLabel.sizeToFit()
        
        self.scheduledLabel.centerYAnchor.constraint(equalTo: self.rightContainer.centerYAnchor, constant: -15).isActive = true
        self.scheduledLabel.leftAnchor.constraint(equalTo: self.rightContainer.leftAnchor, constant: 10).isActive = true
        self.scheduledLabel.rightAnchor.constraint(equalTo: self.rightContainer.rightAnchor, constant: -10).isActive = true
        self.scheduledLabel.sizeToFit()
        
        self.timeFrameLabel.topAnchor.constraint(equalTo: self.scheduledLabel.bottomAnchor, constant: 6).isActive = true
        self.timeFrameLabel.leftAnchor.constraint(equalTo: self.rightContainer.leftAnchor, constant: 10).isActive = true
        self.timeFrameLabel.rightAnchor.constraint(equalTo: self.rightContainer.rightAnchor, constant: -10).isActive = true
        self.timeFrameLabel.sizeToFit()
       
    }
    
    func shouldExpand(should : Bool) {
        if should {
            self.subContainer.isHidden = false
        } else {
            self.subContainer.isHidden = true
        }
    }
    
    @objc func handleButtonSelection(sender : UIButton) {
        self.profileCollectionSubview?.handleClockedButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



