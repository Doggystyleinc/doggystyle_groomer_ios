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
    let databaseRef = Database.database().reference()
    let mainLoadingScreen = MainLoadingScreen()
    
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
        dh.isHidden = true
        
       return dh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.runDataEngine()
        
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
        
        self.headerLabel.topAnchor.constraint(equalTo: self.notificationBubble.bottomAnchor, constant: 53).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 14).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.sizeToFit()
        
        self.groomerChecklistCollection.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 20).isActive = true
        self.groomerChecklistCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.groomerChecklistCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.groomerChecklistCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

    }
    
    @objc func runDataEngine() {
        
        self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
        
        //MARK: - GRAB THE PLAYBOOK KEY FROM THE ALL USERS NODE FOR PLAYBOOKS REFERENCE
        self.grabPlayBookKey { doesKeyExist, returnedKey, user_uid in
            
            if doesKeyExist {
                
                //MARK: - CHECK TO SEE IF THE GROOMER HAS COMPLETED THEIR PROFILE MANAGEMENT
                self.checkProfileManagentCompletion(groomerKey: returnedKey) { hasCompletedProfileManagement in
                    
                    if hasCompletedProfileManagement {
                        print("User has completed profile management")
                        self.mainLoadingScreen.cancelMainLoadingScreen()

                    } else {
                        print("User has NOT completed profile management")
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        self.unhideGroomerProfileSetup()
                    }
                }
                
            } else {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                AlertControllerCompletion.handleAlertWithCompletion(title: "FATAL ERROR", message: "Please reach out to HQ @ \(Statics.SUPPORT_EMAIL_ADDRESS) and let them know your account needs attention. Please append this unique ID to the email as well: \(user_uid) - thank you.") { isComplete in
                    self.homeController?.handleLogout()
                }
            }
        }
    }

    func unhideGroomerProfileSetup() {
        
        self.groomerChecklistCollection.isHidden = false
        self.subHeaderLabel.isHidden = false
        
    }
    
    @objc func grabPlayBookKey(completion : @escaping (_ keyExists : Bool, _ returnedKey : String, _ userUID : String) -> () ) {
      
        guard let user_uid = Auth.auth().currentUser?.uid else {
            self.homeController?.handleLogout()
            completion(false, "nil", "nil")
            return
        }
    
        let ref = self.databaseRef.child("all_users").child(user_uid).child("groomer_child_key_from_playbook")
        
        ref.observeSingleEvent(of: .value) { snap in
            
            let value = snap.value as? String ?? "nil"
            
            if value == "nil" {
                completion(false, value, user_uid)
            } else {
                completion(true, value, user_uid)
            }
        }
    }
    
    func checkProfileManagentCompletion(groomerKey : String, completion : @escaping (_ hasCompletedProfileManagement : Bool)->()) {
        
        let ref = self.databaseRef.child("play_books").child(groomerKey).child("groomer_has_completed_groomer_profile_management")
        
        ref.observeSingleEvent(of: .value) { snap in
            
            let groomer_has_completed_groomer_profile_management = snap.value as? Bool ?? false
            
            if groomer_has_completed_groomer_profile_management == false {
                completion(false)
            } else {
                completion(true)
            }
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
}



















//
//
//
//
//import Foundation
//import Firebase
//
//class DashboardController : UIViewController {
//
//    var homeController : HomeController?
//
//    let dsCompanyLogoImage : UIImageView = {
//
//        let dcl = UIImageView()
//        dcl.translatesAutoresizingMaskIntoConstraints = false
//        dcl.backgroundColor = .clear
//        dcl.contentMode = .scaleAspectFit
//        dcl.isUserInteractionEnabled = false
//        let image = UIImage(named: "ds_orange_logo")?.withRenderingMode(.alwaysOriginal)
//        dcl.image = image
//        return dcl
//    }()
//
//    let notificationIcon : UIButton = {
//
//        let dcl = UIButton(type: .system)
//        dcl.translatesAutoresizingMaskIntoConstraints = false
//        dcl.backgroundColor = .clear
//        dcl.contentMode = .scaleAspectFit
//        dcl.isUserInteractionEnabled = true
//        let image = UIImage(named: "notification_icon")?.withRenderingMode(.alwaysOriginal)
//        dcl.setBackgroundImage(image, for: .normal)
//        dcl.clipsToBounds = false
//        dcl.layer.masksToBounds = false
//        dcl.layer.shadowColor = coreBlackColor.cgColor
//        dcl.layer.shadowOpacity = 0.2
//        dcl.layer.shadowOffset = CGSize(width: 2, height: 3)
//        dcl.layer.shadowRadius = 4
//        dcl.layer.shouldRasterize = false
//
//        return dcl
//    }()
//
//    let notificationBubble : UIView = {
//
//        let nb = UIView()
//        nb.backgroundColor = coreRedColor
//        nb.translatesAutoresizingMaskIntoConstraints = false
//        nb.isUserInteractionEnabled = false
//        nb.layer.masksToBounds = true
//
//       return nb
//    }()
//
//    let notificationLabel : UILabel = {
//
//        let nl = UILabel()
//        nl.translatesAutoresizingMaskIntoConstraints = false
//        nl.backgroundColor = .clear
//        nl.text = "1"
//        nl.font = UIFont(name: dsSubHeaderFont, size: 12)
//        nl.textColor = coreWhiteColor
//        nl.textAlignment = .center
//
//       return nl
//    }()
//
//    lazy var dashboardHeaderCollectionSubview : DashboardHeaderCollectionSubview = {
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let dh = DashboardHeaderCollectionSubview(frame: .zero, collectionViewLayout: layout)
//        dh.dashboardController = self
//       return dh
//    }()
//
//    let upcomingLabel : UILabel = {
//
//        let nl = UILabel()
//        nl.translatesAutoresizingMaskIntoConstraints = false
//        nl.backgroundColor = .clear
//        nl.text = "Upcoming Appointments"
//        nl.font = UIFont(name: dsHeaderFont, size: 20)
//        nl.textColor = coreBlackColor
//        nl.textAlignment = .left
//        nl.adjustsFontSizeToFitWidth = true
//
//       return nl
//    }()
//
//    lazy var dashboardCollectionSubview : DashboardCollectionSubview = {
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let dh = DashboardCollectionSubview(frame: .zero, collectionViewLayout: layout)
//        dh.dashboardController = self
//       return dh
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.backgroundColor = coreBackgroundWhite
//        self.addViews()
//
//        Service.shared.twilioPinRequest(phone: "8455581855", countryCode: "1", deliveryMethod: "sms") { isComplete in
//
//            if isComplete {
//                print("complete!!!!!!!")
//            } else {
//                print("failed")
//            }
//        }
//    }
//
//    func addViews() {
//
//        self.view.addSubview(self.dsCompanyLogoImage)
//        self.view.addSubview(self.notificationIcon)
//        self.view.addSubview(self.notificationBubble)
//        self.view.addSubview(self.notificationLabel)
//        self.view.addSubview(self.dashboardHeaderCollectionSubview)
//        self.view.addSubview(self.upcomingLabel)
//        self.view.addSubview(self.dashboardCollectionSubview)
//
//        self.dsCompanyLogoImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
//        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
//        self.dsCompanyLogoImage.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2.5).isActive = true
//        self.dsCompanyLogoImage.sizeToFit()
//
//        self.notificationIcon.centerYAnchor.constraint(equalTo: self.dsCompanyLogoImage.centerYAnchor, constant: 0).isActive = true
//        self.notificationIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
//        self.notificationIcon.heightAnchor.constraint(equalToConstant: 54).isActive = true
//        self.notificationIcon.widthAnchor.constraint(equalToConstant: 54).isActive = true
//
//        self.notificationBubble.topAnchor.constraint(equalTo: self.notificationIcon.topAnchor, constant: 5).isActive = true
//        self.notificationBubble.rightAnchor.constraint(equalTo: self.notificationIcon.rightAnchor, constant: -5).isActive = true
//        self.notificationBubble.heightAnchor.constraint(equalToConstant: 18).isActive = true
//        self.notificationBubble.widthAnchor.constraint(equalToConstant: 18).isActive = true
//        self.notificationBubble.layer.cornerRadius = 16/2
//
//        self.notificationLabel.topAnchor.constraint(equalTo: self.notificationBubble.topAnchor, constant: 3).isActive = true
//        self.notificationLabel.leftAnchor.constraint(equalTo: self.notificationBubble.leftAnchor, constant: 2).isActive = true
//        self.notificationLabel.rightAnchor.constraint(equalTo: self.notificationBubble.rightAnchor, constant: -2).isActive = true
//        self.notificationLabel.bottomAnchor.constraint(equalTo: self.notificationBubble.bottomAnchor, constant: -3).isActive = true
//
//        self.dashboardHeaderCollectionSubview.topAnchor.constraint(equalTo: self.dsCompanyLogoImage.bottomAnchor, constant: 5).isActive = true
//        self.dashboardHeaderCollectionSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        self.dashboardHeaderCollectionSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        self.dashboardHeaderCollectionSubview.heightAnchor.constraint(equalToConstant: 90).isActive = true
//
//        self.upcomingLabel.topAnchor.constraint(equalTo: self.dashboardHeaderCollectionSubview.bottomAnchor, constant: 8).isActive = true
//        self.upcomingLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
//        self.upcomingLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
//        self.upcomingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        self.dashboardCollectionSubview.topAnchor.constraint(equalTo: self.upcomingLabel.bottomAnchor, constant: 10).isActive = true
//        self.dashboardCollectionSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        self.dashboardCollectionSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        self.dashboardCollectionSubview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
//
//    }
//
//}
