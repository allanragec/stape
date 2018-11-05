//
//  PlayerManager.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import AVFoundation
import RxSwift
import SDWebImage
import MediaPlayer

class PlayerManager {
    
    static let shared = PlayerManager()
    
    var viewModel: PlayerViewModel?
    
    var currentMusic: Music?
    var musics: [Music]?
    
    var player: AVAudioPlayer?
    var disposable: Disposable?
    
    private init() {
        setupRemoteTransportControls()
    }
    
    func isPlaying() -> Bool {
        return player?.isPlaying ?? false
    }
    
    func setMusics(music: Music, musics: [Music]) {
        self.currentMusic = music
        self.musics = musics
    }
    
    func pauseMusic() {
        viewModel?.showEqualizer(false)
        disposable?.dispose()
        viewModel?.showPlayButton(true)
        player?.pause()
    }
    
    func nextMusic() {
        if let nextMusic = getNextMusic() {
            disposable?.dispose()
            
            playSound(music: nextMusic)
        }
    }
    
    func previousMusic() {
        if let previousMusic = getPreviousMusic() {
            disposable?.dispose()
            
            playSound(music: previousMusic)
        }
    }
    
    private func getPreviousMusic() -> Music? {
        let index = musics?.firstIndex { music -> Bool in
            return music.id == currentMusic?.id
        }
        
        guard let newIndex = index, newIndex > 0  else { return nil }
        
        return musics?[newIndex - 1]
    }
    
    private func getNextMusic() -> Music? {
        let index = musics?.firstIndex { music -> Bool in
            return music.id == currentMusic?.id
        }
        
        guard let newIndex = index, (newIndex + 1) < (musics?.count ?? 0)  else { return nil }
        
        return musics?[newIndex + 1]
    }
    
    func playSound(music: Music? = nil) {
        disposable?.dispose()
        
        if music != nil {
            player = nil
        }
        
        guard let music = music ?? currentMusic else { return }
        
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        currentMusic = music
        
        viewModel?.setupMusic(music: music)
        
        viewModel?.showActivityIndicator(true)
        
        disposable = GetMusicDataInteractor(music: music)
            .execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .flatMap{ self.playSound(data: $0) }
            .do(onNext: { time, initialCurrenTime in
                guard let player = self.player else { return }
                
                self.viewModel?.showActivityIndicator(false)
                let newTime = Float(time - initialCurrenTime)
                let duration = Float(round(player.duration))
                let current = Float(duration - newTime) + 1
                
                self.viewModel?.setDurationTime(player.duration)
                self.viewModel?.setCurrentTime(player.currentTime)
                
                self.viewModel?.updateProgress(current/duration)
            },
            onError: {error in print(error) },
            onCompleted: {
                self.viewModel?.showPlayButton(true)
                self.viewModel?.updateProgress(0)
                self.viewModel?.showEqualizer(false)
                
                if let nextMusic = self.getNextMusic(){
                    self.playSound(music: nextMusic)
                }
            })
            .subscribe()
    }
    
    private func playSound(data: Data) ->  Observable<(Int, Int)> {
        viewModel?.showPlayButton(false)
        viewModel?.showEqualizer(true)
        
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
    
    private func startProgress() -> Observable<(Int, Int)> {
        guard let player = player else { return Observable.empty() }
        
        player.play()
        setupNowPlaying()
        let initialCurrenTime = Int(player.currentTime)
        let duration = Int(round(player.duration))
        
        return counter(from: duration, to: initialCurrenTime)
    }
    
    func counter(from: Int, to: Int) -> Observable<(Int, Int)> {
        return Observable<Int>
            .timer(0, period: 1, scheduler: MainScheduler.instance)
            .take(from - to + 1)
            .map { (from - $0, to) }
    }
}

extension PlayerManager {
    //MARK: External Command Controlls
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [unowned self] event in
            self.playSound()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.player?.rate == 1.0 {
                self.pauseMusic()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            if let _ = self.getNextMusic() {
                self.nextMusic()
                return .success
            }
            
            return .commandFailed
        }
        
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            if let _ = self.getPreviousMusic() {
                self.previousMusic()
                return .success
            }
            
            return .commandFailed
        }
    }
    
   //MARK: External Information
    func setupNowPlaying() {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = currentMusic?.title
        
        if let currentMusic = currentMusic, let album = currentMusic.album {
            let imageCached = SDImageCache.shared()
            let image: UIImage? = imageCached.imageFromCache(forKey: album.coverBig) ??
                imageCached.imageFromCache(forKey: album.coverMedium)
            
            if let image = image {
                nowPlayingInfo[MPMediaItemPropertyArtwork] =
                    MPMediaItemArtwork(boundsSize: image.size) { size in
                        return image
                }
            }
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.duration
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
