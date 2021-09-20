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
        cell.checkListLabel.text = titleFeeder
        
        let backgroundColorForSwitch = coreOrangeColor
        let iconTintColor = coreWhiteColor.withAlphaComponent(0.6)
        
        var isComplete : Bool = false
        
        switch titleFeeder {
        
        case "Profile picture" :
            
            cell.checkListIcon.backgroundColor = coreWhiteColor
            cell.checkListIcon.setTitle("", for: .normal)
            cell.checkListIcon.setTitleColor(iconTintColor, for: .normal)
            cell.checkListIcon.backgroundColor = iconTintColor
            cell.mainContainer.backgroundColor = backgroundColorForSwitch
            
            if isComplete == true {
                cell.checkListCheckMark.isHidden = false
            } else {
                cell.checkListCheckMark.isHidden = true
            }
            
        case "Drivers license" :
            
            cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .idCard), for: .normal)
            cell.checkListIcon.setTitleColor(iconTintColor, for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.mainContainer.backgroundColor = backgroundColorForSwitch
            
            if isComplete == true {
                cell.checkListCheckMark.isHidden = false
            } else {
                cell.checkListCheckMark.isHidden = true
            }

        case "Background check" :
            
            cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .userCheck), for: .normal)
            cell.checkListIcon.setTitleColor(iconTintColor, for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.mainContainer.backgroundColor = backgroundColorForSwitch
            
            if isComplete == true {
                cell.checkListCheckMark.isHidden = false
            } else {
                cell.checkListCheckMark.isHidden = true
            }

        case "Payment preferences" :
            
            cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .passport), for: .normal)
            cell.checkListIcon.setTitleColor(iconTintColor, for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.mainContainer.backgroundColor = backgroundColorForSwitch
            
            if isComplete == true {
                cell.checkListCheckMark.isHidden = false
            } else {
                cell.checkListCheckMark.isHidden = true
            }
            
        case "Employee agreement" :
            
            cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .signature), for: .normal)
            cell.checkListIcon.setTitleColor(iconTintColor, for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.mainContainer.backgroundColor = backgroundColorForSwitch
            
            if isComplete == true {
                cell.checkListCheckMark.isHidden = false
            } else {
                cell.checkListCheckMark.isHidden = true
            }
            

        default: print("nothing here")
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 15
    }
    
    func handleSelection(sender : UIButton) {
        
        let selectedButtonCell = sender.superview as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        
        let titleFeeder = self.titleArray[indexPath.item]
        
        switch titleFeeder {
        
        case "Profile picture" : self.handleProfileSelectionTaps()
        case "Drivers license" : self.handleDriversLicenseTaps()
        case "Background check" : self.handleBackgroundTaps()
        case "Payment preferences" : self.handlepaymentPreferencesTaps()
        case "Employee agreement" : self.handleEmployeeAgreementTaps()

        default: print("nothing here")
            
        }
    }
    
    func handleProfileSelectionTaps() {
        self.dashboardController?.handleGroomerProfileController()
    }
    
    func handleDriversLicenseTaps() {
        self.dashboardController?.handleDriversLicenseController()
    }
    
    func handleBackgroundTaps() {
        self.dashboardController?.handleBackgroundCheckController()
    }
    
    func handlepaymentPreferencesTaps() {
        self.dashboardController?.handleLinkBankAccountController()
    }
    
    func handleEmployeeAgreementTaps() {
        self.dashboardController?.handleEmployeeAgreementController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
