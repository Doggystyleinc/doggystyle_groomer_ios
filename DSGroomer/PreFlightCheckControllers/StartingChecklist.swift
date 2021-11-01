//
//  StartingChecklist.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 11/1/21.
//

import Foundation
import UIKit


class StartingChecklist : UIViewController {
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let startingLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Starting Checklist"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let confirmLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Starting Checklist"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack.withAlphaComponent(0.6)
        return thl
        
    }()
    
    lazy var readyToGroomButton: UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Ready to Groom!", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.layer.cornerRadius = 18
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.backgroundColor = coreOrangeColor
        cbf.alpha = 0.5
        cbf.addTarget(self, action: #selector(self.handleReadyToGroom), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var checklistCollectionview : ChecklistCollectionview = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let clcv = ChecklistCollectionview(frame: .zero, collectionViewLayout: layout)
        clcv.translatesAutoresizingMaskIntoConstraints = false
        clcv.startingChecklist = self
        
       return clcv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.startingLabel)
        self.view.addSubview(self.confirmLabel)
        self.view.addSubview(self.checklistCollectionview)
        self.view.addSubview(self.readyToGroomButton)

        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.startingLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 23).isActive = true
        self.startingLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.startingLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.startingLabel.sizeToFit()
        
        self.confirmLabel.topAnchor.constraint(equalTo: self.startingLabel.bottomAnchor, constant: 8).isActive = true
        self.confirmLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.confirmLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.confirmLabel.sizeToFit()
        
        self.readyToGroomButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        self.readyToGroomButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.readyToGroomButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.readyToGroomButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.checklistCollectionview.topAnchor.constraint(equalTo: self.confirmLabel.bottomAnchor, constant: 20).isActive = true
        self.checklistCollectionview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.checklistCollectionview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.checklistCollectionview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true

    }
    
    @objc func handleReadyToGroom() {
        
    }
    
    @objc func handleBackButton() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
