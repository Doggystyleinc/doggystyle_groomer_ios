//
//  ActiveDogPickupCollectionView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 11/2/21.
//


import Foundation
import UIKit

class ActiveDogAppointmentCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    //MARK: - ID AND STATUS
    private let activeDogID = "activeDogID"
    var activeDogPickupPopup : ActiveDogPickupPopup?
    
    //MARK: - CONTROLLER INITIALIZATION THROUGH LAZY INST.
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = coreWhiteColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        
        self.isPrefetchingEnabled = false
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true
        self.canCancelContentTouches = false
        self.contentInsetAdjustmentBehavior = .never
        self.delaysContentTouches = true
        
        //MARK: - REGISTRATION
        self.register(ActiveDogPickupFeeder.self, forCellWithReuseIdentifier: self.activeDogID)
        
    }
    
    //MARK: - CLASS PROTOCOL STUBS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.activeDogID, for: indexPath) as! ActiveDogPickupFeeder
        cell.activeDogAppointmentCollectionView = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //MARK: - SUBCLASS PROTOCOL
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ActiveDogPickupFeeder : UICollectionViewCell {
    
    var activeDogAppointmentCollectionView : ActiveDogAppointmentCollectionView?
    
    let leftLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Description left"
        thl.font = UIFont(name: rubikRegular, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = softGrey
        thl.backgroundColor = .green
        return thl
        
    }()
    
    let rightLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "Description right"
        thl.font = UIFont(name: rubikRegular, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        thl.backgroundColor = .purple
        return thl
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.leftLabel)
        self.addSubview(self.rightLabel)

        self.leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36).isActive = true
        self.leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.leftLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        self.leftLabel.sizeToFit()
        
        self.rightLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -36).isActive = true
        self.rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.rightLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        self.rightLabel.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
