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
    
    let orangeContainer : UIView = {
        
        let oc = UIView()
        oc.translatesAutoresizingMaskIntoConstraints = false
        oc.backgroundColor = coreOrangeColor
        oc.isUserInteractionEnabled = false
        return oc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        self.addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tutorialClass?.hideBottomButtons(shouldHide: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tutorialClass?.hideBottomButtons(shouldHide: true)
    }
    
    @objc func addViews() {
        
        self.view.addSubview(self.orangeContainer)
        self.view.addSubview(self.subHeaderLabel)
        self.view.addSubview(self.virtualTourViewer)
        
        self.virtualTourViewer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        self.virtualTourViewer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        self.virtualTourViewer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        self.virtualTourViewer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.virtualTourViewer.bottomAnchor, constant: 20).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        self.subHeaderLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.orangeContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.orangeContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.orangeContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.orangeContainer.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50).isActive = true
        
    }
}



