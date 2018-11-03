//
//  PlayerViewController.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

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
    
    lazy var viewModel: PlayerViewModel = {
        return PlayerViewModel(self)
    }()
    
    var playerManager = PlayerManager.shared
    
    var currentMusic: Music?
    var musics: [Music]?
    
    init() {
        super.init(nibName: "PlayerViewController", bundle: nil)
    }
    
    init(music: Music, musics: [Music]) {
        self.currentMusic = music
        self.musics = musics
        
        super.init(nibName: "PlayerViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func playAction(_ sender: Any) {
        if playerManager.isPlaying() {
            playerManager.pauseMusic()
        }
        else {
            playerManager.playSound()
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        playerManager.nextMusic()
    }
    @IBAction func previousAction(_ sender: Any) {
        playerManager.previousMusic()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
