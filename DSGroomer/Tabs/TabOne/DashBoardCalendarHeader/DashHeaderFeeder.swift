//
//  DashHeaderFeeder.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/13/21.
//

import Foundation

class DashHeaderFeeder : UICollectionViewCell {
    
    let dateContainer : UIView = {
        
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
    
    let dayLabel : UILabel = {
        
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.backgroundColor = coreWhiteColor
        dl.text = "Mon"
        dl.font = UIFont(name: dsHeaderFont, size: 14)
        dl.textColor = coreGrayColor.withAlphaComponent(0.5)
        dl.textAlignment = .center
        
       return dl
    }()
    
    let numberLabel : UILabel = {
        
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.backgroundColor = coreWhiteColor
        dl.text = "12"
        dl.font = UIFont(name: dsSubHeaderFont, size: 14)
        dl.textColor = coreGrayColor.withAlphaComponent(0.5)
        dl.textAlignment = .center
        
       return dl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = coreBackgroundWhite
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.dateContainer)
        self.addSubview(self.dayLabel)
        self.addSubview(self.numberLabel)

        self.dateContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.dateContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.dateContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.dateContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.dateContainer.layer.cornerRadius = 12
        
        self.dayLabel.topAnchor.constraint(equalTo: self.dateContainer.topAnchor, constant: 5).isActive = true
        self.dayLabel.leftAnchor.constraint(equalTo: self.dateContainer.leftAnchor, constant: 5).isActive = true
        self.dayLabel.rightAnchor.constraint(equalTo: self.dateContainer.rightAnchor, constant: -5).isActive = true
        self.dayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.numberLabel.bottomAnchor.constraint(equalTo: self.dateContainer.bottomAnchor, constant: -5).isActive = true
        self.numberLabel.leftAnchor.constraint(equalTo: self.dateContainer.leftAnchor, constant: 5).isActive = true
        self.numberLabel.rightAnchor.constraint(equalTo: self.dateContainer.rightAnchor, constant: -5).isActive = true
        self.numberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
