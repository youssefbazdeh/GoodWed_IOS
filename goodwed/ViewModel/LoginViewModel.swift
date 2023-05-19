//
//  LoginViewModel.swift
//  CarLovers
//
//  Created by DaliCharf on 31/3/2023.
//

import Alamofire


class LoginViewModel: ObservableObject {
    
    var loginRequest: LoginRequest?
    var errorMessage: String?
    
    let userDefaultsKey = "accessToken"
    let idUser = "idUser"
 
    
    @Published var test: Bool = false
    func logout(){
        UserDefaults.standard.set(false,forKey: "test")
        test=false
    }
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> ()) -> DataRequest {
        let url = "\(base_url)/user/login"
        let userDefault = UserDefaults.standard
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            var urlRequest = try URLRequest(url: url, method: .post)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedRequest
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { [self] response in
                    switch response.result {
                        case .success(let data):
                            do {
                                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                                let user = loginResponse.user // Utilisez cette ligne pour récupérer toutes les informations sur l'utilisateur
                               

                                completion(.success(loginResponse))
                                self.test=true
                                userDefault.set(self.test, forKey: "test")
                                UserDefaults.standard.set(loginResponse.accessToken,forKey: self.userDefaultsKey)
                                if let userID = loginResponse.user._id {
                                    UserDefaults.standard.set(userID, forKey: self.idUser)
                                    
                                }

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

