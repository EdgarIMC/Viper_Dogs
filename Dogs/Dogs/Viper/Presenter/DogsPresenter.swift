//
//  DogsPresenter.swift
//  ApiDogsViper
//
//  Created by 1017143 on 15/11/22.
//
//

import Foundation

class DogsPresenter  {
    
    // MARK: Properties
    weak var view: DogsViewProtocol?
    var interactor: DogsInteractorInputProtocol?
    var router: DogsRouterProtocol?
    
}

extension DogsPresenter: DogsPresenterProtocol {
    
    func getDogs() {
        interactor?.getDogs()
    }
    
    func getDog(indexPath: Int) -> Dog? {
        return interactor?.getDog(indexPath: indexPath)
    }
    
    func getTotalDogs() -> Int? {
        return interactor?.getTotalDogs()
    }
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension DogsPresenter: DogsInteractorOutputProtocol {
    
    func showDogs(dogs: Dogs) {
        self.view?.showDogs()
        self.view?.showMainDog(dog: dogs[Int.random(in: 0..<dogs.count)])
    }
    
    
}
