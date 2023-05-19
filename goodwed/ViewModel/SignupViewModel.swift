import Foundation
import Alamofire

class SignupViewModel: ObservableObject {
    
    var signupRequest: SignupRequest?
    var errorMessage: String?
    
    func signup(request: SignupRequest, completion: @escaping (Result<SignupResponse, Error>) -> ()) -> DataRequest {
        let url = "\(base_url)/user/signup"
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            let parameters = try JSONSerialization.jsonObject(with: encodedRequest, options: []) as? [String: Any]
            
            return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let signupResponse = try JSONDecoder().decode(SignupResponse.self, from: data)
                            completion(.success(signupResponse))
                        } catch {
                            print(error)
                            completion(.failure(error))
                        }
                        
                        
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
        } catch {
            print(error)
            completion(.failure(error))
        }
        // default return statement
        return AF.request(url)
    }
}
