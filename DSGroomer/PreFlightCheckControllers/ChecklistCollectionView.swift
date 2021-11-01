//
//  File.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 11/1/21.
//


import Foundation
import UIKit

class ChecklistCollectionview : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private let checklistID = "checklistID"
    
    var startingChecklist : StartingChecklist?
    
    var arrayOfSelections = [IndexPath]()
    
    let descriptionNames : [String] = ["Check water level", "Check supplies", "Check tools", "Check power", "Enough treats?"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = coreBackgroundWhite
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
        
        self.register(ChecklistCollectionFeeder.self, forCellWithReuseIdentifier: self.checklistID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.descriptionNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 90)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.checklistID, for: indexPath) as! ChecklistCollectionFeeder
        
        cell.checklistCollectionview = self
        
        let feeder = self.descriptionNames[indexPath.item]
        
        cell.descriptionLabel.text = feeder
        
        if !self.arrayOfSelections.contains(indexPath) {
            cell.selectionButton.setTitle("", for: .normal)
            cell.descriptionLabel.textColor = coreBlackColor
        } else {
            cell.selectionButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 23, style: .solid)
            cell.selectionButton.setTitle(String.fontAwesomeIcon(name: .checkCircle), for: .normal)
            cell.selectionButton.setTitleColor(coreOrangeColor, for: .normal)
            cell.descriptionLabel.textColor = coreBlackColor.withAlphaComponent(0.5)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func handleSelectionButton(sender : UIButton) {
        
        let selectedButtonCell = sender.superview as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        
        if !self.arrayOfSelections.contains(indexPath) {
            self.arrayOfSelections.append(indexPath)
            
        } else {
           if let indexOf = self.arrayOfSelections.firstIndex(of: indexPath) {
            self.arrayOfSelections.remove(at: indexOf)
            }
        }
        
        DispatchQueue.main.async {
            self.reloadItems(at: [indexPath])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChecklistCollectionFeeder : UICollectionViewCell {
    
    var checklistCollectionview : ChecklistCollectionview?
    
    lazy var mainContainer : UIButton = {
        
        let mc = UIButton()
        mc.translatesAutoresizingMaskIntoConstraints = false
        mc.backgroundColor = coreWhiteColor
        mc.clipsToBounds = false
        mc.layer.masksToBounds = false
        mc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        mc.layer.shadowOpacity = 0.05
        mc.layer.shadowOffset = CGSize(width: 2, height: 3)
        mc.layer.shadowRadius = 9
        mc.layer.shouldRasterize = false
        mc.layer.cornerRadius = 20
        mc.addTarget(self, action: #selector(self.handleSelectionTap(sender:)), for: .touchUpInside)
        
       return mc
    }()
    
    lazy var selectionButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        
        cbf.layer.masksToBounds = true
        cbf.layer.borderWidth = 3
        cbf.layer.borderColor = lightGreyButtonColor.cgColor
        cbf.isUserInteractionEnabled = false
        return cbf
        
    }()
    
    let descriptionLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = ""
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreBlackColor
        return thl
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addViews()
        
    }
    
    
    func addViews() {
        
        self.addSubview(self.mainContainer)
        
        self.mainContainer.addSubview(self.selectionButton)
        self.mainContainer.addSubview(self.descriptionLabel)

        self.mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.mainContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.mainContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        
        self.selectionButton.rightAnchor.constraint(equalTo: self.mainContainer.rightAnchor, constant: -20).isActive = true
        self.selectionButton.centerYAnchor.constraint(equalTo: self.mainContainer.centerYAnchor, constant: 0).isActive = true
        self.selectionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.selectionButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.selectionButton.layer.cornerRadius = 15
        
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 30).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.selectionButton.leftAnchor, constant: -20).isActive = true
        self.descriptionLabel.centerYAnchor.constraint(equalTo: self.mainContainer.centerYAnchor, constant: 0).isActive = true
        self.descriptionLabel.sizeToFit()

    }
    
    @objc func handleSelectionTap(sender : UIButton) {
        
        self.checklistCollectionview?.handleSelectionButton(sender : sender)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
