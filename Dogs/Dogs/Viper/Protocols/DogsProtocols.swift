//
//  DogsProtocols.swift
//  ApiDogsViper
//
//  Created by 1017143 on 15/11/22.
//
//

import Foundation
import UIKit

protocol DogsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: DogsPresenterProtocol? { get set }
    func showDogs()
    func showMainDog(dog: Dog)
}

protocol DogsRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createDogsModule() -> UIViewController
}

protocol DogsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: DogsViewProtocol? { get set }
    var interactor: DogsInteractorInputProtocol? { get set }
    var router: DogsRouterProtocol? { get set }
    func getDogs()
    func getTotalDogs() -> Int?
    func getDog(indexPath: Int) -> Dog?
    func viewDidLoad()
}

protocol DogsInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func showDogs(dogs: Dogs)
}

protocol DogsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DogsInteractorOutputProtocol? { get set }
    var localDatamanager: DogsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DogsRemoteDataManagerInputProtocol? { get set }
    func getDogs()
    func getDog(indexPath: Int) -> Dog?
    func getTotalDogs() -> Int?
}

protocol DogsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol DogsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DogsRemoteDataManagerOutputProtocol? { get set }
    /// Eliminar esta clase una vez terminada la implementación de las ultimas dos funciones
    ///
    func getRequestApi(request: URLRequest, completionHandler: @escaping (Result<[WelcomeElement], Error>) -> Void)
    func load<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
    func decodeResponse<T:Decodable>(with data: Data, decoder: JSONDecoder) -> T?
}

protocol DogsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func setResponseApi(response: Dogs)
}

protocol DogsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
