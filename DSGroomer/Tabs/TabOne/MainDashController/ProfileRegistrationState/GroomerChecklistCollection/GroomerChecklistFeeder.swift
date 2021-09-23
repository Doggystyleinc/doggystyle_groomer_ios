//
//  DashboardMainFeeder.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/13/21.
//


import Foundation
import ShimmerSwift

class GroomerChecklistFeeder : UICollectionViewCell {
    
    var groomerChecklistCollection : GroomerChecklistCollection?
    
    lazy var mainContainer : UIButton = {
        
        let dc = UIButton(type: .system)
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
        dc.isUserInteractionEnabled = true
        dc.addTarget(self, action: #selector(self.handleSelection(sender:)), for: .touchUpInside)
        
       return dc
    }()
    
    let shimmerView : ShimmeringView = {
        
        let sv = ShimmeringView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isShimmering = true
        sv.layer.shadowOpacity = 0.05
        sv.layer.shadowOffset = CGSize(width: 2, height: 3)
        sv.layer.shadowRadius = 9
        sv.layer.shouldRasterize = false
        sv.isUserInteractionEnabled = true
        sv.layer.cornerRadius = 12
        sv.layer.masksToBounds = true
        
       
        
       return sv
        
    }()
    
    let checkListIcon : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        dcl.backgroundColor = .clear
        dcl.isUserInteractionEnabled = false
        
        return dcl
    }()
    
    let checkListLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = ""
        thl.font = UIFont(name: dsHeaderFont, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreWhiteColor
        thl.isUserInteractionEnabled = false

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
        cbf.isUserInteractionEnabled = false

        return cbf
        
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreBackgroundWhite
        self.addViews()
        
        self.shimmerView.shimmerSpeed = 230
//        self.shimmerView.shimmerDirection = .down
    }
    
    func addViews() {
        
        self.addSubview(self.shimmerView)
        self.shimmerView.contentView = self.mainContainer
//        self.addSubview(self.mainContainer)
        
        self.addSubview(self.checkListIcon)
        self.addSubview(self.checkListLabel)
        self.addSubview(self.checkListCheckMark)
       
        self.shimmerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.shimmerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.shimmerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        self.shimmerView.heightAnchor.constraint(equalToConstant: 91).isActive = true
        self.shimmerView.layer.cornerRadius = 20
        
        self.checkListIcon.leftAnchor.constraint(equalTo: self.shimmerView.leftAnchor, constant: 20).isActive = true
        self.checkListIcon.centerYAnchor.constraint(equalTo: self.shimmerView.centerYAnchor, constant: 0).isActive = true
        self.checkListIcon.heightAnchor.constraint(equalToConstant: 49).isActive = true
        self.checkListIcon.widthAnchor.constraint(equalToConstant: 49).isActive = true
        self.checkListIcon.layer.cornerRadius = 49/2
        
        self.checkListCheckMark.rightAnchor.constraint(equalTo: self.shimmerView.rightAnchor, constant: -20).isActive = true
        self.checkListCheckMark.centerYAnchor.constraint(equalTo: self.shimmerView.centerYAnchor, constant: 0).isActive = true
        self.checkListCheckMark.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.checkListCheckMark.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.checkListLabel.leftAnchor.constraint(equalTo: self.checkListIcon.rightAnchor, constant: 20).isActive = true
        self.checkListLabel.rightAnchor.constraint(equalTo: self.checkListCheckMark.leftAnchor, constant: -20).isActive = true
        self.checkListLabel.topAnchor.constraint(equalTo: self.shimmerView.topAnchor, constant: 0).isActive = true
        self.checkListLabel.bottomAnchor.constraint(equalTo: self.shimmerView.bottomAnchor, constant: 0).isActive = true

    }
    
    @objc func handleSelection(sender : UIButton) {
        
        self.groomerChecklistCollection?.handleSelection(sender:sender)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
