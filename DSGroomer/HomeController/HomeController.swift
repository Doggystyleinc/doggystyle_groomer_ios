//
//  HomeController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/25/21.
//

import Foundation
import UIKit
import Firebase
import Lottie
import AudioToolbox
import AVFoundation

extension  CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}

extension UIView {
    func translate(_ translation: CGPoint) {
        let destination = center + translation
        let minX = frame.width/2
        let minY = frame.height/2
        let maxX = superview!.frame.width-minX
        let maxY = superview!.frame.height-minY
        center = CGPoint(
            x: min(maxX, max(minX, destination.x)),
            y: min(maxY - 80 ,max(minY + 30, destination.y)))
    }
}

class HomeController : UITabBarController {
    
    let databaseRef = Database.database().reference(),
        mainController = MainController(),
        secondaryController = SecondaryController(),
        tertiaryController = TertiaryController(),
        fourthController = FourthController()
    
    var statusBarHeight : CGFloat = 0.0,
        outgoingAudioCallAudioPlayer = AVAudioPlayer(),
        incomingAudioCallAudioPlayer = AVAudioPlayer(),
        missedAudioCallAudioPlayer = AVAudioPlayer(),
        missedVideoCallAudioPlayer = AVAudioPlayer(),
        outgoingVideoCallAudioPlayer = AVAudioPlayer(),
        incomingVideoCallAudioPlayer = AVAudioPlayer(),
        hasApplicationLockBeenPresented : Bool = false,
        hasApplicationLockCallSubviewBeenPresented : Bool = false,
        keyWindow : UIWindow = UIWindow(),
        viewHasBeenLaidOut : Bool = false,
        startingVerticalConstant: CGFloat  = 0.0,
        startingHorizontalConstant: CGFloat  = 0.0
    
    var successFailureView : UIView = {
        
        let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = true
        lv.backgroundColor = coreWhiteColor
        lv.isUserInteractionEnabled = true
        lv.layer.zPosition = 91
        
        return lv
        
    }()
    
    let failLabel : UILabel = {
        
        let fl = UILabel()
        fl.translatesAutoresizingMaskIntoConstraints = false
        fl.backgroundColor = .clear
        fl.font = UIFont(name: dsSubHeaderFont, size: 20)
        fl.textColor = coreWhiteColor
        fl.textAlignment = .left
        fl.numberOfLines = 1
        fl.adjustsFontSizeToFitWidth = true
        
        return fl
    }()
    
    let systemIcon : UIImageView = {
        
        let si = UIImageView()
        si.translatesAutoresizingMaskIntoConstraints = false
        si.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(pointSize: 17, weight: .ultraLight)
        let image = UIImage(named: "nudge_icon")?.withRenderingMode(.alwaysOriginal)
        si.image = image
        si.tintColor = coreWhiteColor
        si.contentMode = .scaleAspectFit
        
        return si
    }()
    
    let selectionDot : UIView = {
        
        let sd = UIView()
        sd.translatesAutoresizingMaskIntoConstraints = true
        sd.backgroundColor = .systemRed
        sd.isUserInteractionEnabled = false
        
        return sd
    }()
    
    lazy var timerCountDownBubble : UIView = {
        
        let tcdb = UIView()
        tcdb.translatesAutoresizingMaskIntoConstraints = false
        tcdb.backgroundColor = coreRedColor
        tcdb.isUserInteractionEnabled = true
        tcdb.layer.masksToBounds = true
        tcdb.isHidden = true
        tcdb.isUserInteractionEnabled = true
        
        return tcdb
    }()
    
    var countDownTimerLabel : UILabel = {
        
        let cdtl = UILabel()
        cdtl.translatesAutoresizingMaskIntoConstraints = false
        cdtl.backgroundColor = .clear
        cdtl.text = "..."
        cdtl.textColor = coreWhiteColor
        cdtl.textAlignment = .center
        cdtl.adjustsFontSizeToFitWidth = true
        cdtl.font = UIFont(name: dsSubHeaderFont, size: 22)
        cdtl.isHidden = false
        cdtl.isUserInteractionEnabled = false
        return cdtl
    }()
    
    let tappableView : UIView = {
        
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreLightGrayColor
        self.tabBar.backgroundColor = coreLightGrayColor
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.layer.zPosition = 10
        
        NetworkMonitor.shared.startMonitoring()
        
        let ratingLibrary = RatingLibraryExtension()
        ratingLibrary.checkForRating()
        
        self.addTabsAndCustomCenterCircle {
            self.addViews()
            self.switchTabs(tabIndex: 1)
        }
    }
    
    @objc func handleDoubleTap() {
        
        UIDevice.vibrateLight()
        
        if self.timerCountDownBubble.isHidden {
            self.timerCountDownBubble.isHidden = false
        } else {
            self.timerCountDownBubble.isHidden = true
        }
    }
    
    @objc func pan(_ gesture: UIPanGestureRecognizer) {
        self.timerCountDownBubble.translate(gesture.translation(in: self.view))
        gesture.setTranslation(.zero, in: self.view)
        self.view.setNeedsDisplay()
    }

    
    //MARK: - SUNSETTING
    @objc func handleMoveToBackground() {
    }
    @objc func handleCancelRebootScreen() {
    }
    @objc func handleReboot() {
    }
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let insetsTop = self.view.window?.safeAreaInsets.top else {return}
        guard let insetsBottom = self.view.window?.safeAreaInsets.bottom else {return}
        
        globalStatusBarHeight = insetsTop
        globalFooterHeight = insetsBottom
        
        if insetsTop > CGFloat(30.0) {
            self.statusBarHeight = insetsTop
        } else {
            self.statusBarHeight = 30
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if self.viewHasBeenLaidOut == true {return}
        self.viewHasBeenLaidOut = true
        
        guard let insets = self.view.window?.safeAreaInsets.top else {return}
        
        if insets > CGFloat(30.0) {
            self.statusBarHeight = insets
        } else {
            self.statusBarHeight = 30
        }
        
        self.successFailureView.frame = CGRect(x: 0, y: -self.statusBarHeight * 2, width: UIScreen.main.bounds.width, height: statusBarHeight * 2)
        self.successFailureView.isHidden = false
        
        self.systemIcon.bottomAnchor.constraint(equalTo: self.successFailureView.bottomAnchor, constant: -5).isActive = true
        self.systemIcon.leftAnchor.constraint(equalTo: self.successFailureView.leftAnchor, constant: 20).isActive = true
        self.systemIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.systemIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.failLabel.centerYAnchor.constraint(equalTo: self.systemIcon.centerYAnchor, constant: 0).isActive = true
        self.failLabel.leftAnchor.constraint(equalTo: self.systemIcon.rightAnchor, constant: 10).isActive = true
        self.failLabel.rightAnchor.constraint(equalTo: self.successFailureView.rightAnchor, constant: -45).isActive = true
        self.failLabel.sizeToFit()
        
        self.timerCountDownBubble.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.statusBarHeight - 10).isActive = true
        self.timerCountDownBubble.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.timerCountDownBubble.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.timerCountDownBubble.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.timerCountDownBubble.layer.cornerRadius = 15
        
        self.countDownTimerLabel.topAnchor.constraint(equalTo: self.timerCountDownBubble.topAnchor, constant: 3).isActive = true
        self.countDownTimerLabel.leftAnchor.constraint(equalTo: self.timerCountDownBubble.leftAnchor, constant: 5).isActive = true
        self.countDownTimerLabel.rightAnchor.constraint(equalTo: self.timerCountDownBubble.rightAnchor, constant: -5).isActive = true
        self.countDownTimerLabel.bottomAnchor.constraint(equalTo: self.timerCountDownBubble.bottomAnchor, constant: -3).isActive = true
        
        self.tappableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tappableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tappableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        if statusBarHeight == 30 {
            self.tappableView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        } else {
            self.tappableView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    func addViews() {
        
        self.view.addSubview(self.successFailureView)
        self.view.addSubview(self.tappableView)
        self.view.addSubview(self.timerCountDownBubble)
        self.timerCountDownBubble.addSubview(self.countDownTimerLabel)
        
        self.successFailureView.addSubview(systemIcon)
        self.successFailureView.addSubview(failLabel)
        self.successFailureView.isHidden = true
        
    }
  
    func switchTabs(tabIndex : Int) {
        self.selectedIndex = tabIndex
    }
    
    func animateSuccessFailureViewView(directionUp up : Bool, isFailed : Bool, passedText : String) {
        
        if isFailed {
            self.successFailureView.backgroundColor = coreWhiteColor
            self.failLabel.text = passedText
            self.failLabel.textColor = coreBlackColor
        } else {
            self.successFailureView.backgroundColor = coreWhiteColor
            self.failLabel.text = passedText
            self.failLabel.textColor = coreBlackColor
        }
        
        if up == true {
            
            UIView.animate(withDuration: 0.7) {
                
                self.successFailureView.frame = CGRect(x: 0, y: -self.statusBarHeight * 2, width: UIScreen.main.bounds.width, height: self.statusBarHeight * 2)
            }
            
        } else if up == false {
            
            UIView.animate(withDuration: 0.7) {
                
                self.successFailureView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.statusBarHeight * 2)
                self.perform(#selector(self.handleSuccessFailureView), with: nil, afterDelay: 1.5)
                
            }
        }
    }
    
    @objc func handleSuccessFailureView() {
        
        UIView.animate(withDuration: 0.4) {
            
            self.successFailureView.frame = CGRect(x: 0, y: -self.statusBarHeight * 2, width: UIScreen.main.bounds.width, height: self.statusBarHeight * 2)
            
        }
    }
    
    func addTabsAndCustomCenterCircle(completion : @escaping () -> ()) {
        
        let configHome = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        
        guard let home = UIImage(systemName: "house", withConfiguration: configHome)?.withTintColor(.black).withRenderingMode(.alwaysOriginal) else {return}
        guard let homeFill = UIImage(systemName: "house", withConfiguration: configHome)?.withTintColor(.orange).withRenderingMode(.alwaysOriginal) else {return}
        
        guard let tabTwo = UIImage(systemName: "doc", withConfiguration: configHome)?.withTintColor(.black).withRenderingMode(.alwaysOriginal) else {return}
        guard let tabTwoFill = UIImage(systemName: "doc.fill", withConfiguration: configHome)?.withTintColor(.orange).withRenderingMode(.alwaysOriginal) else {return}
        
        guard let tabThree = UIImage(systemName: "bookmark", withConfiguration: configHome)?.withTintColor(.black).withRenderingMode(.alwaysOriginal) else {return}
        guard let tabThreeFill = UIImage(systemName: "bookmark.fill", withConfiguration: configHome)?.withTintColor(.orange).withRenderingMode(.alwaysOriginal) else {return}
        
        guard let tabFour = UIImage(systemName: "gearshape", withConfiguration: configHome)?.withTintColor(.black).withRenderingMode(.alwaysOriginal) else {return}
        guard let tabFourFill = UIImage(systemName: "gearshape.fill", withConfiguration: configHome)?.withTintColor(.orange).withRenderingMode(.alwaysOriginal) else {return}
       
        let mainTab = UINavigationController(rootViewController: self.mainController)
        self.mainController.homeController = self
        mainTab.tabBarItem = UITabBarItem(title: nil, image: home, selectedImage: homeFill)
        
        let secondarytab = UINavigationController(rootViewController: self.secondaryController)
        self.secondaryController.homeController = self
        secondarytab.tabBarItem = UITabBarItem(title: nil, image: tabTwo, selectedImage: tabTwoFill)
        
        let tertiaryTab = UINavigationController(rootViewController: self.tertiaryController)
        self.tertiaryController.homeController = self
        tertiaryTab.tabBarItem = UITabBarItem(title: nil, image: tabThree, selectedImage: tabThreeFill)
        
        let fourthTab = UINavigationController(rootViewController: self.fourthController)
        self.fourthController.homeController = self
        fourthTab.tabBarItem = UITabBarItem(title: nil, image: tabFour, selectedImage: tabFourFill)
      
        viewControllers = [mainTab, secondarytab, tertiaryTab, fourthTab]

        completion()
        
    }
   
}
