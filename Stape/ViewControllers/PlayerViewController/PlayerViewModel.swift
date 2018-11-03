//
//  PlayerViewModel.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class PlayerViewModel {
    
    weak var viewController: PlayerViewController?
    
    init(_ viewController: PlayerViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        guard let viewController = viewController else { return }
        
        setupMusic(music: viewController.currentMusic)
        viewController.playerManager.viewModel = self
        viewController.playerManager.setMusics(music: viewController.currentMusic, musics: viewController.musics)
        viewController.playerManager.playSound(music: viewController.currentMusic)
        
        self.viewController?.equalizerIndicator.type = .audioEqualizer
    }
    
    func setupMusic(music: Music) {
        guard let viewController = viewController else { return }
        
        viewController.artistNameLabel.text = music.artist.name
        
        let url = URL(string: music.album.coverBig)
        
        viewController.coverAlbumImageView.sd_setImage(with: url) { image, _, _, _ in
            UIView.animate(withDuration: 0.6, animations: {
                viewController.view.backgroundColor = image?.getColors().primary
                viewController.equalizerIndicator.color = image?.getColors().secondary ?? .white
            })
        }
        
        viewController.musicNameLabel.text = music.title
        viewController.albumNameLabel.text = music.album.title
    }
    
    func showActivityIndicator(_ show: Bool) {
        guard let viewController = viewController else { return }
        
        if show {
            viewController.activityIndicator.startAnimating()
        }
        else {
            viewController.activityIndicator.stopAnimating()
        }
    }
    
    func showEqualizer(_ show: Bool) {
        guard let viewController = viewController else { return }
        
        if show {
            viewController.equalizerIndicator.startAnimating()
        }
        else {
            viewController.equalizerIndicator.stopAnimating()
        }
    }
    
    func updateProgress(_ value: Float) {
        guard let viewController = viewController else { return }
        
        viewController.progressView.setProgress(value, animated: false)
    }
    
    func showPlayButton(_ show: Bool) {
        guard let viewController = viewController else { return }
        
        let image = show ? "play-big" : "pause-big"
        viewController.playPauseButton.setImage(UIImage(named: image), for: .normal)
    }
    
    func setDurationTime(_ time: TimeInterval) {
        guard let viewController = viewController else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        
        viewController.durationTimeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: time))
    }
    
    func setCurrentTime(_ time: TimeInterval) {
        guard let viewController = viewController else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        
        viewController.currentTimeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: time))
    }
}

