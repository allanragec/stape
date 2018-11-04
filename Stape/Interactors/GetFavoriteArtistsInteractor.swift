//
//  GetFavoriteArtistsInteractor.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class GetFavoriteArtistsInteractor  {
    
    func execute(withAlbums: Bool = false, withTopMusics: Bool = false) -> Observable<[Artist]> {
        var observable = createObservable().map { $0.data }

        if withAlbums {
            observable = observable.flatMap { artists -> Observable<[Artist]> in
                let observables = self.mapArtistsWithAlbums(artists)
                
                return Observable.zip(observables)
            }
        }
        
        if withTopMusics {
            observable = observable.flatMap { artists -> Observable<[Artist]> in
                let observables = self.mapArtistsWithTopMusics(artists)
                
                return Observable.zip(observables)
            }
        }
        
        return observable
    }
    
    private func mapArtistsWithAlbums(_ artists: [Artist]) -> [Observable<Artist>] {
        return artists.map { artist in
            let interactor = GetAlbumsInteractor(artistId: artist.id)
            
            return interactor.execute().map{ albums in
                var artist = artist
                artist.albums = albums
                
                return artist
            }
        }
    }
    
    private func mapArtistsWithTopMusics(_ artists: [Artist]) -> [Observable<Artist>] {
        return artists.map { artist in
            let interactor = GetTopMusicsInteractor(artistId: artist.id)
            
            return interactor.execute().map{ musics in
                var artist = artist
                artist.musics = musics
                
                return artist
            }
        }
    }
}

extension GetFavoriteArtistsInteractor: LoaderCodableObservable {
    typealias T = ArtistsCollection
    
    func getUrl() -> String {
        return "https://api.deezer.com/user/\(Settings.userId ?? "")/artists"
    }
}
