//
//  DashboardCollectionSubview.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/13/21.
//


import Foundation
import UIKit


class GroomerChecklistCollection : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let groomerChecklistID = "groomerChecklistID"
    
    var dashboardController : DashboardController?
    
    let titleArray : [String] = ["Profile picture", "Drivers license", "Background check", "Payment preferences", "Employee agreement"]
    
    var checkListBooleanArray : [Bool] = [false, false, false, false, false]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.register(GroomerChecklistFeeder.self, forCellWithReuseIdentifier: self.groomerChecklistID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 91)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.groomerChecklistID, for: indexPath) as! GroomerChecklistFeeder
        cell.groomerChecklistCollection = self
        
        let titleFeeder = self.titleArray[indexPath.item]
        let completionArray = self.checkListBooleanArray[indexPath.item]
        
        var managementBackgroundColor : UIColor = coreWhiteColor
        var iconTintColor : UIColor = coreWhiteColor
        var shouldShowCheckMark : Bool = false
        var textColor : UIColor = coreBlackColor
        
        if completionArray == true {
            
            managementBackgroundColor = dsDeepBlue.withAlphaComponent(0.12)
            shouldShowCheckMark = false
            iconTintColor = coreWhiteColor.withAlphaComponent(0.6)
            textColor = dsFlatBlack
            
        } else {
            
            managementBackgroundColor = coreOrangeColor
            shouldShowCheckMark = true
            iconTintColor = coreWhiteColor.withAlphaComponent(0.6)
            textColor = coreWhiteColor
        }
        
        cell.checkListLabel.text = titleFeeder
        
        switch titleFeeder {
        
        case "Profile picture" :
            
//            cell.checkListIcon.backgroundColor = coreWhiteColor.withAlphaComponent(0.6)
//            cell.checkListIcon.setTitle("", for: .normal)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .userPlus), for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.checkListIcon.setImage(nil, for: .normal)
            cell.checkListIcon.setBackgroundImage(nil, for: .normal)
            
            
//            cell.loadImage()
            
        case "Drivers license" :
            
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .idCard), for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.checkListIcon.setImage(nil, for: .normal)
            cell.checkListIcon.setBackgroundImage(nil, for: .normal)
            
        case "Background check" :
            
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .userCheck), for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.checkListIcon.setImage(nil, for: .normal)
            cell.checkListIcon.setBackgroundImage(nil, for: .normal)
            
        case "Payment preferences" :
            
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .creditCard), for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.checkListIcon.setImage(nil, for: .normal)
            cell.checkListIcon.setBackgroundImage(nil, for: .normal)
            
        case "Employee agreement" :
            
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .signature), for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.checkListIcon.setImage(nil, for: .normal)
            cell.checkListIcon.setBackgroundImage(nil, for: .normal)
            
        default: print("nothing here")
            
        }
        
        cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
        cell.checkListIcon.setTitleColor(iconTintColor, for: .normal)
        cell.mainContainer.backgroundColor = managementBackgroundColor
        cell.checkListCheckMark.isHidden = shouldShowCheckMark
        cell.checkListLabel.textColor = textColor
        cell.mainContainer.isHidden = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 15
    }
    
    func handleSelection(sender : UIButton) {
        
        let selectedButtonCell = sender.superview as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        
        let titleFeeder = self.titleArray[indexPath.item]
        let isCompleted = self.checkListBooleanArray[indexPath.item]
        
        switch titleFeeder {
        
        case "Profile picture" :
            
            if isCompleted == false {
                self.handleProfileSelectionTaps()
            }
            
        case "Drivers license" :
            
            if isCompleted == false {
            self.handleDriversLicenseTaps()
            }
            
        case "Background check" :
            
            if isCompleted == false {
            self.handleBackgroundTaps()
            }
            
        case "Payment preferences" :
            
            if isCompleted == false {
            self.handlepaymentPreferencesTaps()
            }
            
        case "Employee agreement" :
            
            if isCompleted == false {
            self.handleEmployeeAgreementTaps()
            }

        default: print("nothing here")
            
        }
    }
    
    func handleProfileSelectionTaps() {
        UIDevice.vibrateLight()
        self.dashboardController?.handleGroomerProfileController()
    }
    
    func handleDriversLicenseTaps() {
        UIDevice.vibrateLight()
        self.dashboardController?.handleDriversLicenseController()
    }
    
    func handleBackgroundTaps() {
        UIDevice.vibrateLight()
        self.dashboardController?.handleBackgroundCheckController()
    }
    
    func handlepaymentPreferencesTaps() {
        UIDevice.vibrateLight()
        self.dashboardController?.handleLinkBankAccountController()
    }
    
    func handleEmployeeAgreementTaps() {
        UIDevice.vibrateLight()
        self.dashboardController?.handleEmployeeAgreementController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
