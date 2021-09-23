//
//  VideoSubview.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/23/21.
//


import Foundation
import UIKit
import Lottie
import AVFoundation

class VideoControlSubview : UIView {
    
    var playerLayer : AVPlayerLayer?,
        player: AVPlayer?,
        isVolumeOn : Bool = false,
        isVideoPresented : Bool = false,
        finishProfileSubview : FinishProfileSubview?
    
    lazy var volumeButton : UIButton = {
        
        let vb = UIButton(type: .system)
        vb.translatesAutoresizingMaskIntoConstraints = false
        vb.backgroundColor = .clear
        vb.contentMode = .scaleAspectFill
        vb.imageView?.contentMode = .scaleAspectFill
        vb.tintColor = coreWhiteColor
        vb.addTarget(self, action: #selector(self.handleVolumeButton), for: UIControl.Event.touchUpInside)
        return vb
        
    }()
    
    lazy var volumeSlider : UISlider = {
        
        let vs = UISlider()
        vs.translatesAutoresizingMaskIntoConstraints = false
        vs.maximumValue = 1.0
        vs.minimumValue = 0.0
        vs.backgroundColor = .clear
        vs.setThumbImage(UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal)
        vs.tintColor = coreWhiteColor
        vs.minimumTrackTintColor = coreOrangeColor
        vs.maximumTrackTintColor = coreWhiteColor
        vs.value = 0.5
        vs.addTarget(self, action: #selector(self.handleVolumeSlider), for: UIControl.Event.valueChanged)
        return vs
        
    }()
    
    lazy var lottiMusicAnimation : AnimationView = {
        
        let lla = AnimationView(name: "music_anim_icon_2")
        lla.translatesAutoresizingMaskIntoConstraints = false
        lla.backgroundColor = .clear
        lla.contentMode = .scaleAspectFit
        lla.loopMode = .loop
        lla.backgroundBehavior = .pauseAndRestore
        return lla
        
    }()
    
    var controlContainer : UIView = {
        
        let cc = UIView()
        cc.backgroundColor = dsFlatBlack.withAlphaComponent(0.15)
        cc.alpha = 0
        cc.isUserInteractionEnabled = true
        cc.translatesAutoresizingMaskIntoConstraints = false
        return cc
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.backgroundColor = dsFlatBlack
        self.addViews()
        self.loopVideoNotification()
        
        let gestureSingleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        gestureSingleTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(gestureSingleTap)
        
    }
    
    func addViews() {
        
        self.addSubview(self.controlContainer)

        self.controlContainer.addSubview(self.volumeButton)
        self.controlContainer.addSubview(self.volumeSlider)
        
        self.addSubview(self.lottiMusicAnimation)

        self.controlContainer.layer.zPosition = 51
        self.lottiMusicAnimation.layer.zPosition = 52
        
        self.controlContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.controlContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.controlContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.controlContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.volumeButton.centerYAnchor.constraint(equalTo: self.controlContainer.centerYAnchor, constant: 0).isActive = true
        self.volumeButton.leftAnchor.constraint(equalTo: self.controlContainer.leftAnchor, constant: 15).isActive = true
        self.volumeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.volumeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.lottiMusicAnimation.centerYAnchor.constraint(equalTo: self.controlContainer.centerYAnchor, constant: 0).isActive = true
        self.lottiMusicAnimation.rightAnchor.constraint(equalTo: self.controlContainer.rightAnchor, constant: -8).isActive = true
        self.lottiMusicAnimation.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.lottiMusicAnimation.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.volumeSlider.centerYAnchor.constraint(equalTo: self.controlContainer.centerYAnchor, constant: 0).isActive = true
        self.volumeSlider.leftAnchor.constraint(equalTo: self.volumeButton.rightAnchor, constant: 20).isActive = true
        self.volumeSlider.rightAnchor.constraint(equalTo: self.lottiMusicAnimation.leftAnchor, constant: -20).isActive = true
        self.volumeSlider.heightAnchor.constraint(equalToConstant: 15).isActive = true
      
    }
    
    private func loopVideoNotification() {
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { (_) in
            
            if self.player != nil {
                self.player!.seek(to: CMTime.zero)
                self.finishProfileSubview?.playButton.isHidden = false
                self.lottiMusicAnimation.stop()
            }
        }
    }
    
    func initializeVideoPlayerWithVideo() {
        
        if self.player == nil {
            
            guard let path = Bundle.main.path(forResource: "puppy_filler_video", ofType:"mp4") else {
                debugPrint("Can't find the puppy demo video")
                return
            }
            
            let videoUrl = URL(fileURLWithPath: path)
            self.player = AVPlayer(url: videoUrl)
            self.player?.volume = 1.0
            let layer: AVPlayerLayer = AVPlayerLayer(player: player)
            layer.frame = self.bounds
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.layer.addSublayer(layer)
            
        }
    }
    
    @objc func handlePlayButton() {
        
        if self.player == nil {return}
        self.player?.play()
        self.lottiMusicAnimation.play()
    }
    
    @objc func handleVolumeButton(sender : UIButton) {
        
        if self.isVolumeOn == true {
            self.isVolumeOn = false
            
            if self.player != nil {
                let image = UIImage(systemName: "speaker.1")?.withRenderingMode(.alwaysTemplate)
                self.volumeButton.setImage(image, for: UIControl.State.normal)
                self.player?.volume = 0.0
            }
            
        } else if self.isVolumeOn == false {
            self.isVolumeOn = true
            
            let image = UIImage(systemName: "speaker.1.fill")?.withRenderingMode(.alwaysTemplate)
            self.volumeButton.setImage(image, for: UIControl.State.normal)
            
            if self.player != nil {
                
                self.player?.volume = self.volumeSlider.value
                self.volumeSlider.value = Float(self.player!.volume)
            }
        }
    }
    
    func shutDownAVPlayer() {
        
        if self.player != nil {
            
            self.removeFromSuperview()
            self.playerLayer?.removeFromSuperlayer()
            self.player?.pause()
            self.player = nil
            self.lottiMusicAnimation.stop()
            
        }
    }
    
    func prepareForReuse() {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        self.removeFromSuperview()
        self.playerLayer?.removeFromSuperlayer()
        self.player = nil
        
    }
    
    @objc func handleVolumeSlider(sender : UISlider) {
        
        if self.player != nil {
            
            if self.isVolumeOn == true {
                self.player?.volume = Float(sender.value)
            }
        }
    }
    
    @objc func handleSingleTap() {
        
        if self.isVideoPresented == true {
            self.isVideoPresented = false
            
            UIView.animate(withDuration: 0.3) {
                self.controlContainer.alpha = 0
            }
            
        } else if self.isVideoPresented == false {
            self.isVideoPresented = true
            
            UIView.animate(withDuration: 0.3) {
                self.controlContainer.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
