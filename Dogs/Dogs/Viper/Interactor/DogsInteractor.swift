//
//  DogsInteractor.swift
//  ApiDogsViper
//
//  Created by 1017143 on 15/11/22.
//
//

import Foundation

class DogsInteractor: DogsInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: DogsInteractorOutputProtocol?
    private let breeds = EndPoint.breeds
    var localDatamanager: DogsLocalDataManagerInputProtocol?
    var remoteDatamanager: DogsRemoteDataManagerInputProtocol?
    var dogs: Dogs = []

    func getDogs() {
        remoteDatamanager?.getRequestApi(request: breeds.request, completionHandler: { result in
            switch result {
            case .success(let value):
                self.dogs = value
                self.setResponseApi(response: value)
            case .failure(let error):
                fatalError("Se dio un error \(error)")
            }
        })
    }
    
    func getDog(indexPath: Int) -> Dog? {
        return dogs[indexPath]
    }
    
    func getMainDog(){
//        presenter?.showMainDog(dog: dogs[Int.random(in: 0..<dogs.count)])
    }
    
    func getTotalDogs() -> Int? {
        return dogs.count
    }
}

extension DogsInteractor: DogsRemoteDataManagerOutputProtocol {
    func setResponseApi(response: Dogs) {
        presenter?.showDogs(dogs: dogs)
    }
}
