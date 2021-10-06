//
//  MainController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation
import Firebase
import FontAwesome_swift

class DashboardController : UIViewController {
    
    var homeController : HomeController?
    let databaseRef = Database.database().reference(),
         mainLoadingScreen = MainLoadingScreen()
    
    lazy var notificationIcon : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = true
        dcl.clipsToBounds = false
        dcl.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        dcl.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        dcl.tintColor = bellgrey
        dcl.addTarget(self, action: #selector(self.handleNotificationsController), for: .touchUpInside)
        
        return dcl
    }()
    
    let notificationBubble : UILabel = {
        
        let nb = UILabel()
        nb.backgroundColor = UIColor.red
        nb.translatesAutoresizingMaskIntoConstraints = false
        nb.isUserInteractionEnabled = false
        nb.layer.masksToBounds = true
        nb.font = UIFont(name: dsHeaderFont, size: 11)
        nb.textAlignment = .center
        nb.layer.borderColor = coreWhiteColor.cgColor
        nb.layer.borderWidth = 1.5
        nb.text = "1"
        nb.textColor = coreWhiteColor
        nb.isHidden = true
        
        return nb
    }()
    
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
        dcl.addTarget(self, action: #selector(self.handleHelpController), for: .touchUpInside)
        
        return dcl
    }()
    
    let headerLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Welcome!"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsFlatBlack
        
        return hl
    }()
    
    lazy var showTruckContainerButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronDown), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        cbf.isHidden = true
        cbf.addTarget(self, action: #selector(self.showTruckContainer), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let subHeaderLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Please complete the following steps to set up your Doggystylist account:"
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        hl.isHidden = true
        
        return hl
    }()

    lazy var groomerChecklistCollection : GroomerChecklistCollection = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let dh = GroomerChecklistCollection(frame: .zero, collectionViewLayout: layout)
        dh.dashboardController = self
        dh.alpha = 0
        
       return dh
    }()
    
    lazy var finishProfileSubview : FinishProfileSubview = {

        let dh = FinishProfileSubview()
        dh.dashboardController = self
        dh.alpha = 0
        
       return dh
    }()
    
    lazy var groomerWorkingDashboard : GroomerWorkingDashboard = {

        let dh = GroomerWorkingDashboard()
        dh.dashboardController = self
        dh.alpha = 0
        
       return dh
    }()
    
    let broadcastingColorCircle : UIView = {
        
        let bcc = UIView()
        bcc.translatesAutoresizingMaskIntoConstraints = false
        bcc.layer.masksToBounds = true
        bcc.backgroundColor = coreRedColor
        
        return bcc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.runDataEngine()
        self.postObservers()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fillValues()
    }
    
    func addViews() {
        
        self.view.addSubview(self.notificationIcon)
        self.view.addSubview(self.notificationBubble)
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.informationIcon)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.subHeaderLabel)
        self.view.addSubview(self.groomerChecklistCollection)
        self.view.addSubview(self.finishProfileSubview)
        self.view.addSubview(self.groomerWorkingDashboard)
        self.view.addSubview(self.showTruckContainerButton)
        self.view.addSubview(self.broadcastingColorCircle)

        self.informationIcon.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
        self.informationIcon.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.informationIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.informationIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.dsCompanyLogoImage.centerYAnchor.constraint(equalTo: self.informationIcon.centerYAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 26).isActive = true

        self.notificationIcon.centerYAnchor.constraint(equalTo: self.informationIcon.centerYAnchor, constant: 0).isActive = true
        self.notificationIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.notificationIcon.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.notificationIcon.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.notificationBubble.topAnchor.constraint(equalTo: self.notificationIcon.topAnchor, constant: 7).isActive = true
        self.notificationBubble.rightAnchor.constraint(equalTo: self.notificationIcon.rightAnchor, constant: -7).isActive = true
        self.notificationBubble.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.notificationBubble.widthAnchor.constraint(equalToConstant: 23).isActive = true
        self.notificationBubble.layer.cornerRadius = 23/2
        
        self.showTruckContainerButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.showTruckContainerButton.topAnchor.constraint(equalTo: self.notificationBubble.bottomAnchor, constant: 48).isActive = true
        self.showTruckContainerButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        self.showTruckContainerButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.notificationBubble.bottomAnchor, constant: 53).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.showTruckContainerButton.leftAnchor, constant: -5).isActive = true
        self.headerLabel.sizeToFit()

        self.subHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 14).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.sizeToFit()
        
        self.groomerChecklistCollection.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 15).isActive = true
        self.groomerChecklistCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.groomerChecklistCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.groomerChecklistCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.finishProfileSubview.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.finishProfileSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.finishProfileSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.finishProfileSubview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.groomerWorkingDashboard.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.groomerWorkingDashboard.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.groomerWorkingDashboard.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.groomerWorkingDashboard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.broadcastingColorCircle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100).isActive = true
        self.broadcastingColorCircle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100).isActive = true
        self.broadcastingColorCircle.heightAnchor.constraint(equalToConstant: 5).isActive = true
        self.broadcastingColorCircle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45).isActive = true
        self.broadcastingColorCircle.layer.cornerRadius = 2.5

    }
    
    func postObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.runDataEngine), name: NSNotification.Name(Statics.RUN_DATA_ENGINE), object: nil)
    }
    
    func handleProfileManagementCompletionSetup() {
        
        let usersName = groomerUserStruct.groomers_first_name?.capitalizingFirstLetter() ?? "Doggy Stylist"
        self.headerLabel.text = "Hi \(usersName)"
        
        self.groomerChecklistCollection.alpha = 0
        self.groomerChecklistCollection.isHidden = true
        
        self.groomerWorkingDashboard.alpha = 0.0
        self.groomerWorkingDashboard.isHidden = true
        
        self.finishProfileSubview.alpha = 1.0
        self.finishProfileSubview.isHidden = false
        
        UIView.animate(withDuration: 0.25) {
            self.finishProfileSubview.alpha = 1.0
        } completion: { complete in
            print("Finish Profile Managent is now loaded")
        }
    }
    
    func setupTheUsersDashboard() {
        
        //MARK: - INITIAL CHECKLIST FOR THE GROOMER PROFILE MANAGEMENT
        self.groomerChecklistCollection.alpha = 0
        self.groomerChecklistCollection.isHidden = true
        
        //MARK: - GROOMER BIO WITH VIDEO VIEW
        self.finishProfileSubview.alpha = 0
        self.finishProfileSubview.isHidden = true
        
        //MARK: - GROOMER WORKING DASHBOARD WITH TRUCK ASSIGNMENT
        self.groomerWorkingDashboard.alpha = 1.0
        self.groomerWorkingDashboard.isHidden = false
        
    }
    
    @objc func showTruckContainer() {
        self.groomerWorkingDashboard.handleTruckContainerShow()
    }
    
    func unhideGroomerProfileSetup() {
        
        UIView.animate(withDuration: 0.55) {
            self.groomerChecklistCollection.alpha = 1
        }
        self.subHeaderLabel.isHidden = false
    }
    
    func handleGroomerCollectionReload() {
        
        DispatchQueue.main.async {
            self.groomerChecklistCollection.reloadData()
        }
    }
    
    func fillValues() {
        
        let groomersFirstName = groomerUserStruct.groomers_first_name ?? "stylist"
        let capsFirstLetter = groomersFirstName.capitalizingFirstLetter()
        self.headerLabel.text = "Welcome, \(capsFirstLetter)"
        
    }
    
    @objc func handleNotificationsController() {
        print("Notifications")
    }
    
    @objc func handleHelpController() {
        
        let supportController = ContactSupportController()
        
        let nav = UINavigationController(rootViewController: supportController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
    
    @objc func handleGroomerProfileController() {
        
        let groomerProfileController = GroomerProfileController()
        groomerProfileController.dashboardController = self
        let nav = UINavigationController(rootViewController: groomerProfileController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: {
        })
    }
    
    @objc func handleDriversLicenseController() {
        
        let driversLicenseController = DriverLicenseController()
        driversLicenseController.dashboardController = self
        let nav = UINavigationController(rootViewController: driversLicenseController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: {
        })
    }
    
    @objc func handleBackgroundCheckController() {
        
        let backgroundCheckController = BackgroundCheckController()
        let nav = UINavigationController(rootViewController: backgroundCheckController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: {
        })
    }
    
    @objc func handleLinkBankAccountController() {
        
        let linkBankAccountController = LinkBankAccountController()
        let nav = UINavigationController(rootViewController: linkBankAccountController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: {
        })
    }
    
    @objc func handleEmployeeAgreementController() {
        
        let employeeAgreementController = EmployeeAgreementController()
        let nav = UINavigationController(rootViewController: employeeAgreementController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: {
        })
    }
    
    @objc func handleCompleteProfilePresentation() {
        
        let completeProfile = CompleteProfileController()
        completeProfile.dashboardController = self
        let nav = UINavigationController(rootViewController: completeProfile)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
    
    @objc func handleProfileContainer() {
        
    }
    
    @objc func handlePlayVideoButton() {
        
    }
}
















