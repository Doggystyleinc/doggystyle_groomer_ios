//
//  TutorialController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/30/21.
//

import UIKit
import UserNotifications

class TutorialClass : UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController](),
        isNotificationsEnabled : Bool = false,
        gradientLayer: CAGradientLayer!,
        hasViewBeenLaidOut : Bool = false
    
    let pageControl = UIPageControl(),
        initialPage = 0,
        page1 = SlideOne(),
        page2 = SlideTwo(),
        page3 = SlideThree()
    
    lazy var registerButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Register", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 16)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreWhiteColor
        cbf.layer.cornerRadius = 14
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handleSignUpButton), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    lazy var alreadyHaveAccountButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("I already have an account", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 16)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.layer.cornerRadius = 3
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleLoginButton), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    let dsCompanyLogoImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        let image = UIImage(named: "ds_white_logo")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        return dcl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.references()
        self.view.backgroundColor = coreOrangeColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    func addViews() {
        
        self.dataSource = self
        self.delegate = self
        
        //ADD THE VIEWCONTROLLERS TO THE PAGEVIEWCONTROLLER ARRAY
        self.pages.append(self.page1)
        self.pages.append(self.page2)
        self.pages.append(self.page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        self.pageControl.currentPageIndicatorTintColor = coreWhiteColor
        self.pageControl.pageIndicatorTintColor = coreWhiteColor.withAlphaComponent(0.2)
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.alreadyHaveAccountButton)
        self.view.addSubview(self.pageControl)
        self.view.addSubview(self.registerButton)
        self.view.addSubview(self.dsCompanyLogoImage)
        
        self.alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -23).isActive = true
        self.alreadyHaveAccountButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.alreadyHaveAccountButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.alreadyHaveAccountButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.registerButton.bottomAnchor.constraint(equalTo: self.alreadyHaveAccountButton.topAnchor, constant: -18).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: self.view.frame.height / 14).isActive = true
        self.registerButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.registerButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        
        self.pageControl.bottomAnchor.constraint(equalTo: self.registerButton.topAnchor, constant: -19).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.dsCompanyLogoImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.dsCompanyLogoImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        self.dsCompanyLogoImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func references() {
        
        self.page3.tutorialClass = self
        self.page2.tutorialClass = self
        self.page1.tutorialClass = self
        
    }
    
    @objc func handleSignUpButton() {
        
        let registrationController = RegistrationLoginController()
        registrationController.isRegistration = true
        self.navigationController?.pushViewController(registrationController, animated: true)
        UIDevice.vibrateLight()
    }
    
    @objc func handleLoginButton() {
        
        let registrationController = RegistrationLoginController()
        registrationController.isRegistration = false
        self.navigationController?.pushViewController(registrationController, animated: true)
        UIDevice.vibrateLight()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            print(viewControllerIndex)
            if viewControllerIndex > 0 {
                return self.pages[viewControllerIndex - 1]
            }
        }
        
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



