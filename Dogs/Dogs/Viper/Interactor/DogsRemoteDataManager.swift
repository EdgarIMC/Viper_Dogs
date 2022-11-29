//
//  DogsRemoteDataManager.swift
//  ApiDogsViper
//
//  Created by 1017143 on 15/11/22.
//
//


import UIKit
enum EndPoint {
    static let urlBase = "https://api.thedogapi.com"
    static let apiKey = "live_fTvCX8nYCX74R7gvs96mABBxNekA6ti532b0tbk1Zxynm2jWsJcIEZ6DrtQLLB4h"
    static let httpHeader = "x-api-key"

    case breeds
}

extension EndPoint {
    ///Utilizamos una variable computada para devolver el valor de acuerdo caso del enum
    var urlString: String {
        switch self {
        case .breeds:
            return "/v1/breeds?limit=10&page=0"
        }
    }
    
    var request: URLRequest {
        switch self {
        case .breeds:
            guard let url = URL(string: EndPoint.urlBase + urlString) else { fatalError("Url not found") }
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(EndPoint.httpHeader, forHTTPHeaderField: EndPoint.apiKey)
            return request
        }
    }
}

class DogsRemoteDataManager: DogsRemoteDataManagerInputProtocol {
    
    private let session = URLSession.init(configuration: .default)
    var remoteRequestHandler: DogsRemoteDataManagerOutputProtocol?
    
    func load<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
            let response: T = self.decodeResponse(with: data) else {
                return
            }
            completion(.success(response))
        }.resume()
    }
    
    func decodeResponse<T>(with data: Data, decoder: JSONDecoder = JSONDecoder()) -> T? where T : Decodable {
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch let error as NSError {
            fatalError("No se pudo parsear la información \(error.localizedDescription)")
        }
    }
    
    
    func getRequestApi(request: URLRequest, completionHandler: @escaping (Result<[WelcomeElement], Error>) -> Void) {
        load(request: request, completion: completionHandler)
    }
}

