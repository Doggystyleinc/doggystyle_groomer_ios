//
//  DashboardMainFeeder.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/13/21.
//


import Foundation

class DashboardMainFeeder : UICollectionViewCell {
    
    let mainContainer : UIView = {
        
        let dc = UIView()
        dc.translatesAutoresizingMaskIntoConstraints = false
        dc.backgroundColor = coreWhiteColor
        dc.isUserInteractionEnabled = true
        dc.clipsToBounds = false
        dc.layer.masksToBounds = false
        dc.layer.shadowColor = coreBlackColor.cgColor
        dc.layer.shadowOpacity = 0.2
        dc.layer.shadowOffset = CGSize(width: 2, height: 3)
        dc.layer.shadowRadius = 4
        dc.layer.shouldRasterize = false
        
       return dc
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = coreBackgroundWhite
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.mainContainer)
        self.mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.mainContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.mainContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.mainContainer.layer.cornerRadius = 18
       

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
