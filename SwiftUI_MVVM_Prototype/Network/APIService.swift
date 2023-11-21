import Foundation
import Alamofire

class APIService {
    private let url: String
    private var method: HTTPMethod = .get
    private var encoding: ParameterEncoding = JSONEncoding.default
    private var params: [String: Any] = [:]
    private let headers = HTTPHeaders()
    
    init(
        url: String,
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = JSONEncoding.default,
        params: [String: Any] = [:]
    ) {
        self.url = url
        self.method = method
        self.encoding = encoding
        self.params = params
    }
    
    func reques<T: Decodable>(completion: (T?) -> Void) {
        AF.request(
            url,
            method: method,
//            parameters: params,
//            encoder: encoding,
            headers: headers
        )
//            .validate()
//            .responseDecodable(completionHandler: <#T##(DataResponse<Decodable, AFError>) -> Void#>)
            
    }
}
