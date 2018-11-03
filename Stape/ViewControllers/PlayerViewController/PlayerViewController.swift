//
//  PlayerViewController.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import AVFoundation
import RxSwift
import NVActivityIndicatorView

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var coverAlbumImageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var equalizerIndicator: NVActivityIndicatorView!
    
    var currentMusic: Music
    let musics: [Music]
    
    var player: AVAudioPlayer?
    var disposable: Disposable?
    
    var data: Data?
    
    
    init(music: Music, musics: [Music]) {
        self.currentMusic = music
        self.musics = musics
        
        super.init(nibName: "PlayerViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMusic(music: currentMusic)
        
        equalizerIndicator.type = .audioEqualizer
    }
    
    func setupMusic(music: Music) {
        artistNameLabel.text = music.artist.name
        
        let url = URL(string: music.album.coverBig)
        coverAlbumImageView.sd_setImage(with: url) { [weak self] image, _, _, _ in
            guard let strongSelf = self else { return }
            
            UIView.animate(withDuration: 0.6, animations: {
                strongSelf.view.backgroundColor = image?.getColors().primary
                strongSelf.equalizerIndicator.color = image?.getColors().secondary ?? .white
            })
        }
        
        musicNameLabel.text = music.title
        albumNameLabel.text = music.album.title
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func previousMusic() -> Music? {
        let index = musics.firstIndex { music -> Bool in
            return music.id == currentMusic.id
        }
        
        guard let newIndex = index, newIndex > 0  else { return nil }
        
        return musics[newIndex - 1]
    }
    
    func nextMusic() -> Music? {
        let index = musics.firstIndex { music -> Bool in
            return music.id == currentMusic.id
        }
        
        guard let newIndex = index, newIndex < musics.count  else { return nil }
        
        return musics[newIndex + 1]
    }
    
    @IBAction func playAction(_ sender: Any) {
        let isPlaying = player?.isPlaying ?? false
        
        if isPlaying {
            equalizerIndicator.stopAnimating()
            disposable?.dispose()
            playPauseButton.setImage(UIImage(named: "play-big"), for: .normal)
            player?.pause()
        }
        else {
            playSound(music: currentMusic)
        }
    }
    
    func playSound(music: Music) {
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        currentMusic = music
        
        setupMusic(music: music)
        
        activityIndicator.startAnimating()
        
         disposable = GetMusicDataInteractor(music: music)
            .execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .flatMap{ self.playSound(data: $0) }
            .do(onNext: { [weak self] time, initialCurrenTime in
                guard let strongSelf = self, let player = strongSelf.player else { return }
                
                strongSelf.activityIndicator.stopAnimating()
                let newTime = Float(time - initialCurrenTime)
                let duration = Float(round(player.duration))
                let current = Float(duration - newTime) + 1
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "mm:ss"
                strongSelf.durationTimeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: player.duration))
                
                strongSelf.currentTimeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: player.currentTime))
                
                self?.progressView.setProgress(current/duration, animated: false)
                }, onError: {error in print(error) }
                , onCompleted: { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.playPauseButton.setImage(UIImage(named: "play-big"), for: .normal)
                    strongSelf.progressView.setProgress(0, animated: false)
                    strongSelf.equalizerIndicator.stopAnimating()
                    
                    if let nextMusic = strongSelf.nextMusic() {
                        strongSelf.playSound(music: nextMusic)
                    }
            })
            .subscribe()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        disposable?.dispose()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if let nextMusic = nextMusic() {
            disposable?.dispose()
            
            playSound(music: nextMusic)
        }
    }
    @IBAction func previousAction(_ sender: Any) {
        if let previousMusic = previousMusic() {
            disposable?.dispose()
            
            playSound(music: previousMusic)
        }
    }
    
    func playSound(data: Data) ->  Observable<(Int, Int)> {
        playPauseButton.setImage(UIImage(named: "pause-big"), for: .normal)
        equalizerIndicator.startAnimating()
        
        if let player = player, !player.isPlaying && player.currentTime != 0 {
            return startProgress()
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(data: data)
            
            return startProgress()
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        return Observable.empty()
    }
    
    func startProgress() -> Observable<(Int, Int)> {
        guard let player = player else { return Observable.empty() }
        
        player.play()
        let initialCurrenTime = Int(player.currentTime)
        let duration = Int(round(player.duration))
        
        return count(from: duration, to: initialCurrenTime)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func count(from: Int, to: Int) -> Observable<(Int, Int)> {
        return Observable<Int>
            .timer(0, period: 1, scheduler: MainScheduler.instance)
            .take(from - to + 1)
            .map { (from - $0, to) }
    }
}
