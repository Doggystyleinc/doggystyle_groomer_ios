#Remove pods (Troubleshooting) and Re-Install
#sudo gem install cocoapods-deintegrate -> From the terminal
#pod deintegrate -> From Project Directory
#pod install again
#Current platform -> iOS 11.0

platform :ios, '11.0'

#Need frameworks
use_frameworks!

##This allows all the pods to be encapsulted under the varibale shared_pods
def shared_pods
    
    #Firebase pods
    pod 'Firebase'
    pod 'FirebaseCore'
    pod 'FirebaseMessaging'
    pod 'FirebaseDatabase'
    pod 'FirebaseAuth'
    pod 'FirebaseStorage'
    pod 'CollectionViewCenteredFlowLayout'
    pod 'lottie-ios'
    
    #Necessary pods for loading images and making network calls
    pod 'SDWebImage'
    pod 'Alamofire'
    pod 'PINRemoteImage'
    
    #Pod for Phone Number Formatting - International
    pod 'PhoneNumberKit', '~> 3.3'
    
    #Symbols for icons
    pod 'FontAwesome.swift'
    
    #Google Sign in OAUTH
    pod 'GoogleSignIn'
    
    #Places API
    pod 'GooglePlaces'
    
   
end

target 'DSGroomer' do

    #shared_pods represents all the dependencies above
    shared_pods

end





