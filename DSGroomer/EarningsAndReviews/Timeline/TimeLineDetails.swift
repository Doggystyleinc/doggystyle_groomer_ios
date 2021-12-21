//
//  TimeLineDetails.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/17/21.
//

import Foundation
import UIKit

class TimeLineDetails : UIViewController, CustomAlertCallBackProtocol {
    
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
        thl.text = "Timesheet"
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
        rp.timeLineDetails = self
        
        return rp
    }()
    
    lazy var timeLineCollectionView : TimeLineCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let gcv = TimeLineCollectionView(frame: .zero, collectionViewLayout: layout)
        gcv.timeLineDetails = self
        
       return gcv
    }()
    
    let centerDataContainer : UIView = {
        
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
    
    let centralLeftContainer : UIView = {
        
        let vtv = UIView()
        vtv.backgroundColor = coreWhiteColor
        vtv.translatesAutoresizingMaskIntoConstraints = false
        vtv.isUserInteractionEnabled = true
        vtv.layer.cornerRadius = 12
        vtv.layer.masksToBounds = true
        
        return vtv
    }()
    
    let centralRightContainer : UIView = {
        
        let vtv = UIView()
        vtv.backgroundColor = coreWhiteColor
        vtv.translatesAutoresizingMaskIntoConstraints = false
        vtv.isUserInteractionEnabled = true
        vtv.layer.cornerRadius = 12
        vtv.layer.masksToBounds = true
        
        return vtv
    }()
    
    let centralMiddleContainer : UIView = {
        
        let vtv = UIView()
        vtv.backgroundColor = coreWhiteColor
        vtv.translatesAutoresizingMaskIntoConstraints = false
        vtv.isUserInteractionEnabled = true
        vtv.layer.cornerRadius = 12
        vtv.layer.masksToBounds = true
        
        return vtv
    }()
    
    let numberShiftsLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "4"
        thl.font = UIFont(name: rubikBold, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let shiftsLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Shifts"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let numberGroomzLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "22"
        thl.font = UIFont(name: rubikBold, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let groomzLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Groomz"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let numberHoursLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "32.2"
        thl.font = UIFont(name: rubikBold, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let hoursLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Hours"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let leftMiddleDividerView : UIView = {
        
        let mdv = UIView()
        mdv.backgroundColor = dsFlatBlack
        mdv.translatesAutoresizingMaskIntoConstraints = false
        
        return mdv
    }()
    
    let rightMiddleDividerView : UIView = {
        
        let mdv = UIView()
        mdv.backgroundColor = dsFlatBlack
        mdv.translatesAutoresizingMaskIntoConstraints = false
        
        return mdv
    }()
    
    let backDrop : UIView = {
        let bd = UIView()
        bd.translatesAutoresizingMaskIntoConstraints = false
        bd.backgroundColor = UIColor (white: 0, alpha: 0.5)
        bd.alpha = 0
       return bd
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
        self.view.addSubview(self.centerDataContainer)
        
        //MARK: CENTER CONTAINER
        self.centerDataContainer.addSubview(self.centralLeftContainer)
        self.centerDataContainer.addSubview(self.centralRightContainer)
        self.centerDataContainer.addSubview(self.centralMiddleContainer)
        
        self.centralLeftContainer.addSubview(self.numberShiftsLabel)
        self.centralLeftContainer.addSubview(self.shiftsLabel)
        
        self.centralMiddleContainer.addSubview(self.numberGroomzLabel)
        self.centralMiddleContainer.addSubview(self.groomzLabel)
        
        self.centralRightContainer.addSubview(self.numberHoursLabel)
        self.centralRightContainer.addSubview(self.hoursLabel)
        
        self.centerDataContainer.addSubview(self.leftMiddleDividerView)
        self.centerDataContainer.addSubview(self.rightMiddleDividerView)
        
        self.view.addSubview(self.timeLineCollectionView)
        self.view.addSubview(self.backDrop)

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
        
        self.centerDataContainer.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 34).isActive = true
        self.centerDataContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.centerDataContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.centerDataContainer.heightAnchor.constraint(equalToConstant: 82).isActive = true
        
        let centralContainerWidth = UIScreen.main.bounds.width - 60
        
        self.centralLeftContainer.leftAnchor.constraint(equalTo: self.centerDataContainer.leftAnchor, constant: 0).isActive = true
        self.centralLeftContainer.topAnchor.constraint(equalTo: self.centerDataContainer.topAnchor, constant: 0).isActive = true
        self.centralLeftContainer.bottomAnchor.constraint(equalTo: self.centerDataContainer.bottomAnchor, constant: 0).isActive = true
        self.centralLeftContainer.widthAnchor.constraint(equalToConstant: centralContainerWidth / 3.0).isActive = true
        
        self.centralRightContainer.rightAnchor.constraint(equalTo: self.centerDataContainer.rightAnchor, constant: 0).isActive = true
        self.centralRightContainer.topAnchor.constraint(equalTo: self.centerDataContainer.topAnchor, constant: 0).isActive = true
        self.centralRightContainer.bottomAnchor.constraint(equalTo: self.centerDataContainer.bottomAnchor, constant: 0).isActive = true
        self.centralRightContainer.widthAnchor.constraint(equalToConstant: centralContainerWidth / 3.0).isActive = true
        
        self.centralMiddleContainer.rightAnchor.constraint(equalTo: self.centralRightContainer.leftAnchor, constant: 0).isActive = true
        self.centralMiddleContainer.leftAnchor.constraint(equalTo: self.centralLeftContainer.rightAnchor, constant: 0).isActive = true
        self.centralMiddleContainer.topAnchor.constraint(equalTo: self.centerDataContainer.topAnchor, constant: 0).isActive = true
        self.centralMiddleContainer.bottomAnchor.constraint(equalTo: self.centerDataContainer.bottomAnchor, constant: 0).isActive = true
        
        self.numberShiftsLabel.topAnchor.constraint(equalTo: self.centralLeftContainer.topAnchor, constant: 25).isActive = true
        self.numberShiftsLabel.leftAnchor.constraint(equalTo: self.centralLeftContainer.leftAnchor, constant: 10).isActive = true
        self.numberShiftsLabel.rightAnchor.constraint(equalTo: self.centralLeftContainer.rightAnchor, constant: -10).isActive = true
        self.numberShiftsLabel.sizeToFit()
        
        self.shiftsLabel.topAnchor.constraint(equalTo: self.numberShiftsLabel.bottomAnchor, constant: 3).isActive = true
        self.shiftsLabel.leftAnchor.constraint(equalTo: self.centralLeftContainer.leftAnchor, constant: 10).isActive = true
        self.shiftsLabel.rightAnchor.constraint(equalTo: self.centralLeftContainer.rightAnchor, constant: -10).isActive = true
        self.shiftsLabel.sizeToFit()
        
        self.numberGroomzLabel.topAnchor.constraint(equalTo: self.centralMiddleContainer.topAnchor, constant: 25).isActive = true
        self.numberGroomzLabel.leftAnchor.constraint(equalTo: self.centralMiddleContainer.leftAnchor, constant: 10).isActive = true
        self.numberGroomzLabel.rightAnchor.constraint(equalTo: self.centralMiddleContainer.rightAnchor, constant: -10).isActive = true
        self.numberGroomzLabel.sizeToFit()
        
        self.groomzLabel.topAnchor.constraint(equalTo: self.numberGroomzLabel.bottomAnchor, constant: 3).isActive = true
        self.groomzLabel.leftAnchor.constraint(equalTo: self.centralMiddleContainer.leftAnchor, constant: 10).isActive = true
        self.groomzLabel.rightAnchor.constraint(equalTo: self.centralMiddleContainer.rightAnchor, constant: -10).isActive = true
        self.groomzLabel.sizeToFit()
        
        self.numberHoursLabel.topAnchor.constraint(equalTo: self.centralRightContainer.topAnchor, constant: 25).isActive = true
        self.numberHoursLabel.leftAnchor.constraint(equalTo: self.centralRightContainer.leftAnchor, constant: 10).isActive = true
        self.numberHoursLabel.rightAnchor.constraint(equalTo: self.centralRightContainer.rightAnchor, constant: -10).isActive = true
        self.numberHoursLabel.sizeToFit()
        
        self.hoursLabel.topAnchor.constraint(equalTo: self.numberHoursLabel.bottomAnchor, constant: 3).isActive = true
        self.hoursLabel.leftAnchor.constraint(equalTo: self.centralRightContainer.leftAnchor, constant: 10).isActive = true
        self.hoursLabel.rightAnchor.constraint(equalTo: self.centralRightContainer.rightAnchor, constant: -10).isActive = true
        self.hoursLabel.sizeToFit()
        
        self.leftMiddleDividerView.topAnchor.constraint(equalTo: self.centerDataContainer.topAnchor, constant: 20).isActive = true
        self.leftMiddleDividerView.bottomAnchor.constraint(equalTo: self.centerDataContainer.bottomAnchor, constant: -20).isActive = true
        self.leftMiddleDividerView.centerXAnchor.constraint(equalTo: self.centralMiddleContainer.leftAnchor, constant: 0).isActive = true
        self.leftMiddleDividerView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.rightMiddleDividerView.topAnchor.constraint(equalTo: self.centerDataContainer.topAnchor, constant: 20).isActive = true
        self.rightMiddleDividerView.bottomAnchor.constraint(equalTo: self.centerDataContainer.bottomAnchor, constant: -20).isActive = true
        self.rightMiddleDividerView.centerXAnchor.constraint(equalTo: self.centralMiddleContainer.rightAnchor, constant: 0).isActive = true
        self.rightMiddleDividerView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.timeLineCollectionView.topAnchor.constraint(equalTo: self.centerDataContainer.bottomAnchor, constant: 20).isActive = true
        self.timeLineCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.timeLineCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.timeLineCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        self.backDrop.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backDrop.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.backDrop.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.backDrop.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

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
                self.backDrop.alpha = 0

            } completion: { complete in
                self.isWarningPresented = false
                self.earningsIssueReportingPopup.earningsReportingCollection.clearData()
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.earningsIssueReportingPopup.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 1.5)), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                self.view.layoutIfNeeded()
                self.earningsIssueReportingPopup.layoutIfNeeded()
                self.backDrop.alpha = 1

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
            
            UIDevice.vibrateLight()
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
