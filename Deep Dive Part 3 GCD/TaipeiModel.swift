//
//  TaipeiModel.swift
//  Deep Dive Part 3 GCD
//
//  Created by Nick Liu on 2023/5/31.
//

import Alamofire
import Foundation

class TaipeiModel {
    
    static let shared = TaipeiModel()
    
    func getTaipeiData(number: Int, completion: @escaping (Result) -> Void) {
        
        let urlString = "https://data.taipei/api/v1/dataset/c7784a9f-e11e-4145-8b72-95b44fdc7b83?scope=resourceAquire&limit=1&offset=\(number)"
        
        AF.request(urlString, method: .get, parameters: nil)
            .responseDecodable(of: TaipeiData.self) { response in
                switch response.result {
                case .success(let taipeiData):
                    completion(taipeiData.result)
                case .failure(let error):
                    print("Error\(error)")
                }
            }
    }
}
