//
//  ArtistTableViewCell.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    
    var artist: Artist?
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
        albumsCollectionView.register(nibCell, forCellWithReuseIdentifier: "AlbumCollectionViewCell")
        albumsCollectionView.dataSource = self
        albumsCollectionView.delegate = self
    }
    
    func configure(artist: Artist, title: String, subtitle: String? = nil) {
        self.artist = artist
        
        titleLabel.text = title
        subtitleLabel.text = subtitle ?? "\(artist.nbAlbum) albums"
        albumsCollectionView.reloadData()
    }
    
}

extension ArtistTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.artist?.albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath)
        
        
        if let album = artist?.albums?[indexPath.row],
            let cell = cell as? AlbumCollectionViewCell {
                
            cell.configure(album: album)
        }
        
        return cell
    }
}

extension ArtistTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigation = STTabBarController.shared.currentNavigation(),
            let album = artist?.albums?[indexPath.row] else { return }
        
        let albumDetailsViewController = AlbumDetailsViewController(album: album)
        
        navigation.pushViewController(albumDetailsViewController, animated: true)
    }
}
