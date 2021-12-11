//
//  ActiveAppointmentPopup.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 11/2/21.
//


import Foundation
import UIKit

class ActiveDogPickupPopup : UIView, CustomAlertCallBackProtocol {
    
    var mapLocationController : MapLocationController?
    
    let headerContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = coreWhiteColor
        
       return hc
    }()
    
    let footerContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = coreWhiteColor
        
       return hc
    }()
    
    let bodyContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = .green
        
       return hc
    }()
    
    let dividerLine : UIView = {
        
        let dl = UIView()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.backgroundColor = coreBlackColor.withAlphaComponent(0.1)
        
       return dl
    }()
    
    let headerLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Pick up Rex"
        thl.font = UIFont(name: dsHeaderFont, size: 22)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let addressLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "132 NE 30th Ave, Apt 603 Toronto, ON 66777"
        thl.font = UIFont(name: rubikRegular, size: 18)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var sendButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .comment), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        cbf.layer.masksToBounds = true
        cbf.addTarget(self, action: #selector(self.handleChatControllerPresentation), for: .touchUpInside)
        return cbf
        
    }()
    
    lazy var swipeToConfirmActiveSubview : SwipeToConfirmActiveSubview = {
        
       let sc = SwipeToConfirmActiveSubview()
       sc.activeDogPickupPopup = self
        return sc
    }()
    
    lazy var activeDogAppointmentCollectionView : ActiveDogAppointmentCollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let ada = ActiveDogAppointmentCollectionView(frame: .zero, collectionViewLayout: layout)
        ada.activeDogPickupPopup = self
        
        return ada

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreWhiteColor
        self.translatesAutoresizingMaskIntoConstraints = true
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        self.layer.cornerRadius = 20
        self.addViews()
        
    }
    
    func addViews() {
        
        //MARK: - CLASS
        self.addSubview(self.headerContainer)
        self.addSubview(self.footerContainer)
        self.addSubview(self.bodyContainer)
        
        //MARK: - HEADER
        self.headerContainer.addSubview(self.dividerLine)
        self.headerContainer.addSubview(self.headerLabel)
        self.headerContainer.addSubview(self.addressLabel)
        self.headerContainer.addSubview(self.sendButton)
        
        //MARK: - FOOTER
        self.footerContainer.addSubview(self.swipeToConfirmActiveSubview)
        
        //MARK: - BODY
        self.bodyContainer.addSubview(self.activeDogAppointmentCollectionView)

        self.headerContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.headerContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.headerContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.headerContainer.heightAnchor.constraint(equalToConstant: 141).isActive = true
        
        self.footerContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.footerContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.footerContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.footerContainer.heightAnchor.constraint(equalToConstant: 141).isActive = true
        
        self.bodyContainer.topAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: 0).isActive = true
        self.bodyContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.bodyContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.bodyContainer.bottomAnchor.constraint(equalTo: self.footerContainer.topAnchor, constant: 0).isActive = true
        
        //MARK: - HEADER CONTAINER AND LABELS
        self.dividerLine.bottomAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: 0).isActive = true
        self.dividerLine.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 0).isActive = true
        self.dividerLine.rightAnchor.constraint(equalTo: self.headerContainer.rightAnchor, constant: 0).isActive = true
        self.dividerLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.headerContainer.topAnchor, constant: 35).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 35).isActive = true
        self.headerLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        self.headerLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.addressLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 5).isActive = true
        self.addressLabel.leftAnchor.constraint(equalTo: self.headerLabel.leftAnchor, constant: 0).isActive = true
        self.addressLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        self.addressLabel.sizeToFit()
        
        self.sendButton.centerYAnchor.constraint(equalTo: self.headerLabel.centerYAnchor, constant: 0).isActive = true
        self.sendButton.rightAnchor.constraint(equalTo: self.headerContainer.rightAnchor, constant: -30).isActive = true
        self.sendButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        self.sendButton.widthAnchor.constraint(equalToConstant: 41).isActive = true
        self.sendButton.layer.cornerRadius = 41/2
        
        //MARK: - FOOTER CONTAINER AND LABELS
        self.swipeToConfirmActiveSubview.centerYAnchor.constraint(equalTo: self.footerContainer.centerYAnchor, constant: 0).isActive = true
        self.swipeToConfirmActiveSubview.leftAnchor.constraint(equalTo: self.footerContainer.leftAnchor, constant: 30).isActive = true
        self.swipeToConfirmActiveSubview.rightAnchor.constraint(equalTo: self.footerContainer.rightAnchor, constant: -30).isActive = true
        self.swipeToConfirmActiveSubview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //MARK: - BODY CONTAINER AND LABELS
        self.activeDogAppointmentCollectionView.topAnchor.constraint(equalTo: self.bodyContainer.topAnchor, constant: 0).isActive = true
        self.activeDogAppointmentCollectionView.leftAnchor.constraint(equalTo: self.bodyContainer.leftAnchor, constant: 0).isActive = true
        self.activeDogAppointmentCollectionView.rightAnchor.constraint(equalTo: self.bodyContainer.rightAnchor, constant: 0).isActive = true
        self.activeDogAppointmentCollectionView.bottomAnchor.constraint(equalTo: self.bodyContainer.bottomAnchor, constant: 0).isActive = true
        
    }
    
    @objc func handleCancelButton() {
        self.mapLocationController?.handleWarningIcon()
    }
    
    @objc func handleCustomPopUpAlert(title : String, message : String, passedButtons: [String]) {
        
        let alert = AlertController()
        alert.passedTitle = title
        alert.passedMmessage = message
        alert.passedButtonSelections = passedButtons
        alert.customAlertCallBackProtocol = self
        alert.passedIconName = .infoCircle
        alert.modalPresentationStyle = .overCurrentContext
        self.mapLocationController?.present(alert, animated: true, completion: nil)
        
    }
    
    func onSelectionPassBack(buttonTitleForSwitchStatement type: String) {
        
        switch type {
        case Statics.GOT_IT: print("Tapped Got it")
        default: print("Should not hit")
            
        }
    }
    
    @objc func handleSwipeToComplete() {
        print("slider complete")
    }
    
    @objc func handleChatControllerPresentation() {
        self.mapLocationController?.presentChatController()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
