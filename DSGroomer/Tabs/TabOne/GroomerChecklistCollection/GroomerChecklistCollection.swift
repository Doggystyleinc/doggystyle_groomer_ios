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
    
    let titleArray : [String] = ["Profile picture", "Drivers license", "Background check", "Payment preferences"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
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
        
        let backgroundColorForSwitch = dsFlatBlack.withAlphaComponent(0.12)
        
        switch titleFeeder {
        
        case "Profile picture" :
            
            cell.checkListIcon.backgroundColor = coreWhiteColor
            cell.checkListIcon.setTitle("", for: .normal)
            cell.mainContainer.backgroundColor = coreOrangeColor
            
        case "Drivers license" :
            
            cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .idCard), for: .normal)
            cell.checkListIcon.setTitleColor(coreWhiteColor, for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.mainContainer.backgroundColor = backgroundColorForSwitch

        case "Background check" :
            
            cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .userCheck), for: .normal)
            cell.checkListIcon.setTitleColor(coreWhiteColor, for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.mainContainer.backgroundColor = backgroundColorForSwitch

        case "Payment preferences" :
            
            cell.checkListIcon.titleLabel?.font = UIFont.fontAwesome(ofSize: 29, style: .solid)
            cell.checkListIcon.setTitle(String.fontAwesomeIcon(name: .passport), for: .normal)
            cell.checkListIcon.setTitleColor(coreWhiteColor, for: .normal)
            cell.checkListIcon.backgroundColor = .clear
            cell.mainContainer.backgroundColor = backgroundColorForSwitch

        default: print("nothing here")
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
