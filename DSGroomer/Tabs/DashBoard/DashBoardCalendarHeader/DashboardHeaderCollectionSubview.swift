//
//  DashboardHeaderCollectionSubview.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/13/21.
//

import Foundation
import UIKit


class DashboardHeaderCollectionSubview : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let dashHeaderID = "dashHeaderID"
    
    var dashboardController : DashboardController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(DashHeaderFeeder.self, forCellWithReuseIdentifier: self.dashHeaderID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 63, height: 73)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.dashHeaderID, for: indexPath) as! DashHeaderFeeder
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
