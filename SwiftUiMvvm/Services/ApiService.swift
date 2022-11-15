//
//  ApiService.swift
//  SwiftUiMvvm
//
//  Created by Singularity - Jewel Rana on 15/11/22.
//

import Foundation
import Combine

class ApiService{
    
    static let shared = ApiService()
    
    func getUsers() -> AnyPublisher<[UserDm], Error> {
        guard let url = URL(string: "https://api.github.com/users") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        let users = try JSONDecoder().decode([UserDm].self, from: data)
                        return promise(.success(users))
                    } catch let error {
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
    
}
