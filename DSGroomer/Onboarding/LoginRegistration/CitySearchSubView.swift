//
//  CitySearchSubView.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 10/1/21.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

struct PlacesDictionary {
    
    var locationName : String
    var placeId : String
    
    init(json : [String : Any]) {
        
        self.locationName = json["locationName"] as? String ?? ""
        self.placeId = json["placeId"] as? String ?? ""
    }
}

class CitySearchSubView : UIView, UITextFieldDelegate {
    
    var registrationController : RegistrationController?,
        breedHeightAnchor : NSLayoutConstraint?,
        dogBreedJson : [String] = [],
        predictionString : String = "",
        currentBreedArray : [String] = [String](),
        centerConstraint : NSLayoutConstraint?,
        topConstraint : NSLayoutConstraint?,
        placesClient: GMSPlacesClient!,
        arrayLocationNames : [String] = [String]()
    
    
    lazy var citySearchCollection : CitySearchCollection = {
        
        let mc = CitySearchCollection(frame: .zero, style: .plain)
        mc.citySearchSubView = self
        return mc
        
    }()
    
    lazy var cityTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "City", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.backgroundColor = coreWhiteColor
        etfc.textColor = UIColor .darkGray.withAlphaComponent(1.0)
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.layer.masksToBounds = true
        etfc.keyboardAppearance = UIKeyboardAppearance.light
        etfc.returnKeyType = UIReturnKeyType.default
        etfc.leftViewMode = .always
        
        let image = UIImage(named: "magnifyingGlass")?.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView()
        imageView.contentMode = .center
        etfc.contentMode = .center
        imageView.image = image
        etfc.leftView = imageView
        
        etfc.clipsToBounds = false
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.layer.borderColor = dividerGrey.withAlphaComponent(0.2).cgColor
        etfc.layer.borderWidth = 1.0
        etfc.layer.cornerRadius = 10
        
        etfc.addTarget(self, action: #selector(handleSearchTextFieldChange(textField:)), for: .editingChanged)
        
        return etfc
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor (white: 1.0, alpha: 1.0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
        
        self.cityTextField.setUpImage(imageName: "magnifyingGlass", on: .left)
        self.cityTextField.textContentType = UITextContentType(rawValue: "")
        self.addViews()
        self.placesClient = GMSPlacesClient.shared()
        
    }
    
    func addViews() {
        
        self.addSubview(self.cityTextField)
        self.addSubview(self.citySearchCollection)
        
        self.centerConstraint = self.cityTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        self.centerConstraint?.isActive = true
        
        self.cityTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.cityTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.cityTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.citySearchCollection.topAnchor.constraint(equalTo: self.cityTextField.bottomAnchor, constant: 10).isActive = true
        self.citySearchCollection.leftAnchor.constraint(equalTo: self.cityTextField.leftAnchor, constant: 0).isActive = true
        self.citySearchCollection.rightAnchor.constraint(equalTo: self.cityTextField.rightAnchor, constant: 0).isActive = true
        self.breedHeightAnchor = self.citySearchCollection.heightAnchor.constraint(equalToConstant: 48.0)
        self.breedHeightAnchor?.isActive = true
    }
    
    func moveConstraints() {
        
        UIView.animate(withDuration: 0.3) {
            
            self.centerConstraint?.constant = -UIScreen.main.bounds.height / 2.7
            self.layoutIfNeeded()
            
        } completion: { complete in
            
            self.cityTextField.becomeFirstResponder()
            
        }
    }
    
    @objc func handleSearchTextFieldChange(textField: UITextField) {
        
        guard let breedSafeText = self.cityTextField.text else {return}
        
        let safeText = breedSafeText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if safeText.count == 0 {
            
            UIView.animate(withDuration: 0.45) {
                
                self.citySearchCollection.placesArray.removeAll()
                self.currentBreedArray.removeAll()
                self.breedHeightAnchor?.constant = 0.0
                self.citySearchCollection.superview?.layoutIfNeeded()
                
            }
            
            DispatchQueue.main.async {
                self.citySearchCollection.reloadData()
            }
            
        } else {
            
            let currentEnteredText = safeText
            self.placesAutocomplete(passedPlace: currentEnteredText)
            
        }
    }
    
    func placesAutocomplete(passedPlace:String) {
        
        self.citySearchCollection.arrayOfDicts.removeAll()
        self.citySearchCollection.placesArray.removeAll()
        
        UIView.animate(withDuration: 0.4) {
            self.citySearchCollection.alpha = 0
        }
        
        let token = GMSAutocompleteSessionToken.init(),
            filter = GMSAutocompleteFilter()
            filter.type = .city
        
            placesClient?.findAutocompletePredictions(fromQuery: passedPlace, filter: filter, sessionToken: token, callback: { (results, error) in
                
            if let _ = error {
                return
            }
            
            if let results = results {
                for result in results {
                    
                    let filteredResults = result.attributedFullText.string
                    
                    self.citySearchCollection.placesArray.append(filteredResults)
                    
                    let placesId = result.placeID,
                        placeName = filteredResults,
                        dic : [String : Any] = ["locationName" : placeName as Any, "placeId" : placesId as Any],
                        posts = PlacesDictionary(json: dic)
                  
                    self.citySearchCollection.arrayOfDicts.append(posts)
                    
                    DispatchQueue.main.async {
                        
                        self.citySearchCollection.reloadData()
                        
                        UIView.animate(withDuration: 0.4) {
                            
                            self.breedHeightAnchor?.constant = CGFloat(self.citySearchCollection.arrayOfDicts.count * 50)
                            self.citySearchCollection.superview?.layoutIfNeeded()
                            self.citySearchCollection.alpha = 1.0
                            
                        }
                    }
                }
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
