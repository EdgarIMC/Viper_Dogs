//
//  DogsRouter.swift
//  ApiDogsViper
//
//  Created by 1017143 on 15/11/22.
//
//

import Foundation
import UIKit

final class DogsRouter: DogsRouterProtocol {

    class func createDogsModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DogsView")
        if let view = navController as? DogsView {
            let presenter: DogsPresenterProtocol & DogsInteractorOutputProtocol = DogsPresenter()
            let interactor: DogsInteractorInputProtocol & DogsRemoteDataManagerOutputProtocol = DogsInteractor()
            let localDataManager: DogsLocalDataManagerInputProtocol = DogsLocalDataManager()
            let remoteDataManager: DogsRemoteDataManagerInputProtocol = DogsRemoteDataManager()
            let router: DogsRouterProtocol = DogsRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "DogsView", bundle: Bundle(for: DogsView.self))
    }
    
}
