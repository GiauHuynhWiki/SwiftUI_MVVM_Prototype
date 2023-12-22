import Foundation
import Alamofire
import UIKit

class HTTPService {
    static func request(_ url: URLConvertible,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        needAuthorization: Bool = false) -> DataRequest {
        var headers: HTTPHeaders = []
        headers.add(name: "Platform", value: "iOS")
        headers.add(name: "Model", value: UIDevice.modelName)
        headers.add(name: "Version", value: Bundle.main.version)
        headers.add(name: "Build", value: Bundle.main.build)
        if needAuthorization, let accessToken = UserDefaults.standard.string(forKey: "accessTokenKey") {
            headers.add(.authorization(bearerToken: accessToken))
        }
        
        return AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
}

extension DataRequest {
    func responseDecodable<T: Decodable>(completion: @escaping (T?) -> Void) {
        responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                completion(nil)
            }
        }
    }
    
    func responseDecodableWithError<T: Decodable>(completion: @escaping (T?, AFError?) -> Void) {
        responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
