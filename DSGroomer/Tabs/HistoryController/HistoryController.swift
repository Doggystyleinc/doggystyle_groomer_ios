//
//  SecondaryController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation

class HistoryController : UIViewController {
    
    var homeController : HomeController?
    
    var isActiveSelected : Bool = true
    
    let dsCompanyLogoImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        let image = UIImage(named: "ds_orange_logo")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        return dcl
    }()
    
    lazy var activeLabel : UIButton = {
        
        let nl = UIButton(type: .system)
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.setTitle("Active", for: .normal)
        nl.titleLabel?.font = UIFont(name: dsSubHeaderFont, size: 22)
        nl.titleLabel?.textColor = coreBlackColor
        nl.tintColor = coreBlackColor
        nl.tag = 1
        nl.addTarget(self, action: #selector(self.handleActiveSwitch(sender:)), for: .touchUpInside)

       return nl
    }()
    
    lazy var pastLabel : UIButton = {
        
        let nl = UIButton(type: .system)
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.setTitle("Past", for: .normal)
        nl.titleLabel?.font = UIFont(name: dsSubHeaderFont, size: 22)
        nl.titleLabel?.textColor = coreGrayColor.withAlphaComponent(0.5)
        nl.tag = 2
        nl.tintColor = coreGrayColor.withAlphaComponent(0.5)
        nl.addTarget(self, action: #selector(self.handleActiveSwitch(sender:)), for: .touchUpInside)

       return nl
    }()
    
    lazy var historyCollectionSubview : HistoryCollectionSubview = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let dh = HistoryCollectionSubview(frame: .zero, collectionViewLayout: layout)
        dh.historyCollection = self
       return dh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.activeLabel)
        self.view.addSubview(self.pastLabel)
        self.view.addSubview(self.historyCollectionSubview)

        self.dsCompanyLogoImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2.5).isActive = true
        self.dsCompanyLogoImage.sizeToFit()
        
        self.activeLabel.topAnchor.constraint(equalTo: self.dsCompanyLogoImage.bottomAnchor, constant: 20).isActive = true
        self.activeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.activeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.activeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.pastLabel.topAnchor.constraint(equalTo: self.dsCompanyLogoImage.bottomAnchor, constant: 20).isActive = true
        self.pastLabel.leftAnchor.constraint(equalTo: self.activeLabel.rightAnchor, constant: 12).isActive = true
        self.pastLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.pastLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.historyCollectionSubview.topAnchor.constraint(equalTo: self.pastLabel.bottomAnchor, constant: 20).isActive = true
        self.historyCollectionSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.historyCollectionSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.historyCollectionSubview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

    }
    
    @objc func handleActiveSwitch(sender : UIButton) {
        
        if sender.tag == 1 && self.isActiveSelected == true {return}
        if sender.tag == 2 && self.isActiveSelected == false {return}
        
        if self.isActiveSelected == true {
            self.isActiveSelected = false
            self.pastLabel.tintColor = coreBlackColor
            self.activeLabel.tintColor = coreGrayColor.withAlphaComponent(0.5)
        } else {
            self.isActiveSelected = true

            self.activeLabel.tintColor = coreBlackColor
            self.pastLabel.tintColor = coreGrayColor.withAlphaComponent(0.5)
        }
    }
}
