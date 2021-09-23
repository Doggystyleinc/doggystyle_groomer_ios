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
        
        if completionArray == true {
            
            managementBackgroundColor = dsDeepBlue.withAlphaComponent(0.12)
            shouldShowCheckMark = false
            iconTintColor = coreWhiteColor.withAlphaComponent(0.6)

        } else {
            
            managementBackgroundColor = coreOrangeColor
            shouldShowCheckMark = true
            iconTintColor = coreWhiteColor.withAlphaComponent(0.6)

        }
        
        cell.checkListLabel.text = titleFeeder
        
        switch titleFeeder {
        
        case "Profile picture" :
            
            self.orientatoinState(cell: cell, passedBackgroundColor: managementBackgroundColor, passedCheckmarkState: shouldShowCheckMark, icontTintColor: iconTintColor, indexPathItem: indexPath.item)
            
            let imageView = UIImageView()
            let imageURL = groomerUserStruct.profile_image_url ?? "nil"
            print(imageURL, "image url")
            if imageURL != "nil" {
                imageView.loadImageGeneralUse(imageURL) { image in
                    print("loaded the profile image")
                    cell.checkListIcon.setImage(imageView.image, for: .normal)
                }
            }
            
        case "Drivers license" :
            
            self.orientatoinState(cell: cell, passedBackgroundColor: managementBackgroundColor, passedCheckmarkState: shouldShowCheckMark, icontTintColor: iconTintColor, indexPathItem: indexPath.item)

        case "Background check" :
            
            self.orientatoinState(cell: cell, passedBackgroundColor: managementBackgroundColor, passedCheckmarkState: shouldShowCheckMark, icontTintColor: iconTintColor, indexPathItem: indexPath.item)
            
        case "Payment preferences" :
            
            self.orientatoinState(cell: cell, passedBackgroundColor: managementBackgroundColor, passedCheckmarkState: shouldShowCheckMark, icontTintColor: iconTintColor, indexPathItem: indexPath.item)

        case "Employee agreement" :
            
            self.orientatoinState(cell: cell, passedBackgroundColor: managementBackgroundColor, passedCheckmarkState: shouldShowCheckMark, icontTintColor: iconTintColor, indexPathItem: indexPath.item)

        default: print("nothing here")
            
        }
        
        return cell
    }
    
    func orientatoinState(cell : GroomerChecklistFeeder, passedBackgroundColor : UIColor, passedCheckmarkState : Bool, icontTintColor : UIColor, indexPathItem : Int) {
        
        cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
        cell.checkListIcon.setTitleColor(icontTintColor, for: .normal)
        cell.checkListIcon.backgroundColor = .clear
        cell.mainContainer.backgroundColor = passedBackgroundColor
        cell.checkListCheckMark.isHidden = passedCheckmarkState
        cell.checkListIcon.setImage(UIImage(), for: .normal)
        
        switch indexPathItem {
        
        case 0:
            cell.checkListIcon.backgroundColor = coreWhiteColor.withAlphaComponent(0.6)
            cell.checkListIcon.setTitle("", for: .normal)
        case 1: cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .idCard), for: .normal)
        case 2: cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .userCheck), for: .normal)
        case 3: cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .creditCard), for: .normal)
        case 4: cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .signature), for: .normal)
        default:print("default for item in groomer collection")
        }
        
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
