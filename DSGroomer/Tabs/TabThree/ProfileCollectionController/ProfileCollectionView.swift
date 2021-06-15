//
//  ProfileCollectionView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/14/21.
//

import Foundation
import UIKit

class ProfileCollectionSubview : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    //JUST REFERENCE THE STRING NAME FOR THE ICONS FROM THE ASSETS AND PUT THEM IN ORDER ON THE LINE BELOW
    private let profileID = "profileID",
                arrayOfStaticIcons = ["userCircle","dollarSign"],
                arrayOfStaticLabels = ["Account","Earnings & Reviews"]
    
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 1.15, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfStaticIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.profileID, for: indexPath) as! ProfileFeeder
        
        let feederLabels = self.arrayOfStaticLabels[indexPath.item]
        
        cell.profileCollectionSubview = self
        cell.feederLabel.text = feederLabels
        
        switch feederLabels {
        
        case "Account" :
            cell.feederIcon.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
            cell.feederIcon.text = String.fontAwesomeIcon(name: .userCircle)
            cell.feederIcon.textColor = coreOrangeColor
        case "Earnings & Reviews" :
            cell.feederIcon.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
            cell.feederIcon.text = String.fontAwesomeIcon(name: .dollarSign)
            cell.feederIcon.textColor = coreOrangeColor
        default:print("never hit this")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    
    @objc func handleSelection(sender: UIButton) {
        
        let selectedButtonCell = sender.superview as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        
        let feederLabels = self.arrayOfStaticLabels[indexPath.item]
        
        switch feederLabels {
        
        case "Account" : print("Account")
        case "Earnings & Reviews" : print("Earnings & Reviews")
            
        default : print("Button not found, add it to the array")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
