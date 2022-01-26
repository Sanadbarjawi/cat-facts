//
//  FactsApi.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import Foundation
import Alamofire

protocol EndPoint {
    var path: String {get}
}
enum EndPoints: EndPoint {
    case getFacts
    
    var path: String {
        switch self {
        case .getFacts:
            return "https://api.jsonbin.io/b/6064467b418f307e2585ef1b"
        }
    }
}

class ListServices {
    
    func getFacts(completion: @escaping ([CatFact]?, Error?) -> Void) {

        AF.request(EndPoints.getFacts.path)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [CatFact].self, decoder: CustomDecoder()) { response in
                switch response.result {
                case .success:
                    let facts = try! response.result.get()
                    completion(facts, nil)
                case let .failure(error):
                    completion(nil, error)
                }
        }
    }
}

class CustomDecoder: JSONDecoder {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
      }()

    override init() {
        super.init()
        dateDecodingStrategy = .formatted(CustomDecoder.iso8601Full)
    }
}
