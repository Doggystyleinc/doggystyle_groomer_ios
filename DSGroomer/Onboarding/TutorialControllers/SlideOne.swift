//
//  SlideOne.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/30/21.
//


import UIKit
import Foundation

class SlideOne: UIViewController {
    
    var tutorialClass : TutorialClass?
    
    let virtualTourViewer : UIView = {
        
        let vtv = UIView()
        vtv.backgroundColor = coreWhiteColor.withAlphaComponent(0.2)
        vtv.translatesAutoresizingMaskIntoConstraints = false
        vtv.isUserInteractionEnabled = true
        vtv.layer.cornerRadius = 12
        vtv.layer.masksToBounds = true
        
        return vtv
    }()
    
    let subHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Some filler text for the virtual viewer will go here for two lines"
        thl.font = UIFont(name: dsSubHeaderFont, size: 15)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreWhiteColor.withAlphaComponent(0.5)
        
        return thl
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreOrangeColor
        self.addViews()
        
    }
    
    @objc func addViews() {
        
        self.view.addSubview(self.subHeaderLabel)
        self.view.addSubview(self.virtualTourViewer)
        
        self.subHeaderLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        self.subHeaderLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.virtualTourViewer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        self.virtualTourViewer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        self.virtualTourViewer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        self.virtualTourViewer.bottomAnchor.constraint(equalTo: self.subHeaderLabel.topAnchor, constant: -40).isActive = true
        
    }
}



