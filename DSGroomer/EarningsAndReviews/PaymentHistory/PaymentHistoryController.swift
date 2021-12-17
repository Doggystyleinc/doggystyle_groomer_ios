//
//  PaymentHistoryController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/17/21.
//

import Foundation
import UIKit

class PaymentHistoryController : UIViewController, CustomAlertCallBackProtocol {
    
    var isWarningPresented : Bool = false
    
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
    
    let headerLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Payment History"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var informationIcon : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = true
        dcl.clipsToBounds = false
        dcl.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        dcl.setTitle(String.fontAwesomeIcon(name: .questionCircle), for: .normal)
        dcl.tintColor = bellgrey
        dcl.addTarget(self, action: #selector(self.handleQuestionMarkIcon), for: .touchUpInside)
        
        return dcl
    }()
    
    lazy var earningsIssueReportingPopup : EarningsSupportPopup = {
        
        let rp = EarningsSupportPopup(frame: .zero)
        rp.paymentHistoryController = self
        return rp
    }()
    
    let headerContainer : UIView = {
        
        let wc = UIView()
        wc.translatesAutoresizingMaskIntoConstraints = false
        wc.backgroundColor = coreWhiteColor
        wc.isUserInteractionEnabled = true
        wc.layer.masksToBounds = true
        wc.layer.cornerRadius = 20
        wc.clipsToBounds = false
        wc.layer.masksToBounds = false
        wc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        wc.layer.shadowOpacity = 0.05
        wc.layer.shadowOffset = CGSize(width: 2, height: 3)
        wc.layer.shadowRadius = 9
        wc.layer.shouldRasterize = false
        return wc
        
    }()
    
    let dateTimeFrameHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Last Paycheck"
        thl.font = UIFont(name: dsHeaderFont, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let totalEarningsHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "$1436.03"
        thl.font = UIFont(name: dsSubHeaderFont, size: 32)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let footerForHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Paycheck deposited Dec 15th"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    lazy var paymentCollection : PaymentCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let pc = PaymentCollectionView(frame: .zero, collectionViewLayout: layout)
        pc.paymentHistoryController = self
        
       return pc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.informationIcon)
        self.view.addSubview(self.headerContainer)
        
        //MARK: HEADER CONTAINER
        self.headerContainer.addSubview(self.dateTimeFrameHeaderLabel)
        self.headerContainer.addSubview(self.totalEarningsHeaderLabel)
        self.headerContainer.addSubview(self.footerForHeaderLabel)
        
        self.view.addSubview(self.paymentCollection)
        self.view.addSubview(self.earningsIssueReportingPopup)


        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.headerLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.informationIcon.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.informationIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.informationIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.informationIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.headerContainer.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 34).isActive = true
        self.headerContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerContainer.heightAnchor.constraint(equalToConstant: 137).isActive = true
        
        self.dateTimeFrameHeaderLabel.topAnchor.constraint(equalTo: self.headerContainer.topAnchor, constant: 23).isActive = true
        self.dateTimeFrameHeaderLabel.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 30).isActive = true
        self.dateTimeFrameHeaderLabel.rightAnchor.constraint(equalTo: self.headerContainer.rightAnchor, constant: -30).isActive = true
        self.dateTimeFrameHeaderLabel.sizeToFit()
        
        self.totalEarningsHeaderLabel.topAnchor.constraint(equalTo: self.dateTimeFrameHeaderLabel.bottomAnchor, constant: 8).isActive = true
        self.totalEarningsHeaderLabel.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 30).isActive = true
        self.totalEarningsHeaderLabel.rightAnchor.constraint(equalTo: self.headerContainer.rightAnchor, constant: -30).isActive = true
        self.totalEarningsHeaderLabel.sizeToFit()
        
        self.footerForHeaderLabel.topAnchor.constraint(equalTo: self.totalEarningsHeaderLabel.bottomAnchor, constant: 5).isActive = true
        self.footerForHeaderLabel.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 30).isActive = true
        self.footerForHeaderLabel.rightAnchor.constraint(equalTo: self.headerContainer.rightAnchor, constant: -30).isActive = true
        self.footerForHeaderLabel.sizeToFit()
        
        self.paymentCollection.topAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: 20).isActive = true
        self.paymentCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.paymentCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.paymentCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleQuestionMarkIcon() {
        self.handleWarningIcon()
    }
    
    @objc func handleWarningIcon() {
        
        if self.isWarningPresented {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.earningsIssueReportingPopup.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                self.view.layoutIfNeeded()
                self.earningsIssueReportingPopup.layoutIfNeeded()
            } completion: { complete in
                self.isWarningPresented = false
                self.earningsIssueReportingPopup.earningsReportingCollection.clearData()
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.earningsIssueReportingPopup.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 1.5)), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                self.view.layoutIfNeeded()
                self.earningsIssueReportingPopup.layoutIfNeeded()
            } completion: { complete in
                self.isWarningPresented = true
            }
        }
    }
    
    @objc func handleSubmitButton() {
        
        let selection = self.earningsIssueReportingPopup.earningsReportingCollection.collectionArray
        
        let count = selection.count
        
        if count <= 0 {
            print("nothing selected here")
        } else {
            
            Service.shared.supportTicketHandler(typeOfSuportMessage: "payment_issue", supportMessage: selection[0]) { isComplete in
                
                if isComplete {
                    self.handleQuestionMarkIcon()
                    self.handleCustomPopUpAlert(title: "Request", message: "Delivered - you should be hearing from HQ shortly.", passedButtons: [Statics.GOT_IT])
                } else {
                    self.handleQuestionMarkIcon()
                    self.handleCustomPopUpAlert(title: "Failed", message: "Please try again.", passedButtons: [Statics.GOT_IT])
                }
            }
        }
    }
    
   
    
    @objc func handleCustomPopUpAlert(title : String, message : String, passedButtons: [String]) {
        
        let alert = AlertController()
        alert.passedTitle = title
        alert.passedMmessage = message
        alert.passedButtonSelections = passedButtons
        alert.customAlertCallBackProtocol = self
        
        alert.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    
    func onSelectionPassBack(buttonTitleForSwitchStatement type: String) {
        
        switch type {
        
        case Statics.GOT_IT: print(Statics.GOT_IT)
        case Statics.OK: print(Statics.OK)
            
        default: print("Should not hit")
            
        }
    }
}
