//
//  DashboardMainFeeder.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/13/21.
//


import Foundation

class GroomerChecklistFeeder : UICollectionViewCell {
    
    var groomerChecklistCollection : GroomerChecklistCollection?
    
    let mainContainer : UIView = {
        
        let dc = UIView()
        dc.translatesAutoresizingMaskIntoConstraints = false
        dc.backgroundColor = dsDeepBlue.withAlphaComponent(0.12)
        dc.isUserInteractionEnabled = true
        dc.clipsToBounds = false
        dc.layer.masksToBounds = false
        dc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        dc.layer.shadowOpacity = 0.05
        dc.layer.shadowOffset = CGSize(width: 2, height: 3)
        dc.layer.shadowRadius = 9
        dc.layer.shouldRasterize = false
        
       return dc
    }()
    
    let checkListIcon : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        dcl.backgroundColor = .clear
        
        return dcl
    }()
    
    let checkListLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "text goes here"
        thl.font = UIFont(name: dsHeaderFont, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var checkListCheckMark : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .check), for: .normal)
        cbf.setTitleColor(coreGreenColor, for: .normal)
        return cbf
        
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = coreBackgroundWhite
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.mainContainer)
        
        self.addSubview(self.checkListIcon)
        self.addSubview(self.checkListLabel)
        self.addSubview(self.checkListCheckMark)
       
        self.mainContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.mainContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.mainContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        self.mainContainer.heightAnchor.constraint(equalToConstant: 91).isActive = true
        self.mainContainer.layer.cornerRadius = 20
        
        self.checkListIcon.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 20).isActive = true
        self.checkListIcon.centerYAnchor.constraint(equalTo: self.mainContainer.centerYAnchor, constant: 0).isActive = true
        self.checkListIcon.heightAnchor.constraint(equalToConstant: 49).isActive = true
        self.checkListIcon.widthAnchor.constraint(equalToConstant: 49).isActive = true
        self.checkListIcon.layer.cornerRadius = 49/2
        
        self.checkListCheckMark.rightAnchor.constraint(equalTo: self.mainContainer.rightAnchor, constant: -20).isActive = true
        self.checkListCheckMark.centerYAnchor.constraint(equalTo: self.mainContainer.centerYAnchor, constant: 0).isActive = true
        self.checkListCheckMark.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.checkListCheckMark.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.checkListLabel.leftAnchor.constraint(equalTo: self.checkListIcon.rightAnchor, constant: 20).isActive = true
        self.checkListLabel.rightAnchor.constraint(equalTo: self.checkListCheckMark.leftAnchor, constant: -20).isActive = true
        self.checkListLabel.topAnchor.constraint(equalTo: self.mainContainer.topAnchor, constant: 0).isActive = true
        self.checkListLabel.bottomAnchor.constraint(equalTo: self.mainContainer.bottomAnchor, constant: 0).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}