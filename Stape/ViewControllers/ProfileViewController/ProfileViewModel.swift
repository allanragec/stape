//
//  ProfileViewModel.swift
//  Stape
//
//  Created by Allan Melo on 05/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class ProfileViewModel {
    
    weak var viewController: ProfileViewController?
    
    var disposable: Disposable?
    
    init(_ viewController: ProfileViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        guard let viewController = viewController else { return }
        
        viewController.navigationItem.title = "Profile"
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        
        GetUserInteractor(userId: Settings.userId ?? "")
            .execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { self.setUser(user: $0)}
                , onError: { error in self.verifyError(error) })
            .disposed(by: viewController.rx.disposeBag)
    }
    
    private func setUser(user: User) {
        self.viewController?.nameLabel.text = user.name
        let imageUrl = URL(string: user.pictureMedium)
        self.viewController?.portraitImageView.sd_setImage(with: imageUrl, completed: nil)
    }
    
    private func verifyError(_ error: Error) {
        Alert.showNetworkError(error) {}
    }
}

