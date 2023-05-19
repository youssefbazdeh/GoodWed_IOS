//
//  ForgetPswdViewModel.swift
//  CarLovers
//
//  Created by DaliCharf on 7/4/2023.
//

import Foundation
import Alamofire
class ForgetPasswordModel: ObservableObject {
    
    var loginRequest: LoginRequest?
    var errorMessage: String?
    
    
    
    
        @Published var email = ""
        @Published var password = ""
        @Published var confirmPassword = ""

        @Published var usernameError: String? = nil
        @Published var emailError: String? = nil
        @Published var passwordError: String? = nil
        @Published var confirmPasswordError: String? = nil



      


    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)

        if email.isEmpty {
            emailError = "Email is required"
        } else if !emailPredicate.evaluate(with: email) {
            emailError = "Email is invalid"
        } else {
            emailError = nil
        }
    }

    func validatePassword() {
        if password.isEmpty {
            passwordError = "Password is required"
        } else if password.count < 8 {
            passwordError = "Password must be at least 8 characters"
        } else {
            passwordError = nil
        }
    }
func validateConfirmPassword() {
    if confirmPassword.isEmpty {
        confirmPasswordError = "Password is required"
    } else if password != confirmPassword {
        confirmPasswordError = "Passwords must match"
    } else {
        confirmPasswordError = nil
    }
}
    
    func sendEmail(request: SendMailRequest, completion: @escaping (Result<String, Error>) -> ()) -> DataRequest {
        let url = "\(base_url)/user/forget"
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            var urlRequest = try URLRequest(url: url, method: .post)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedRequest
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json"])
                .responseData { response in

                    switch response.result {

                    case .success(_):
                            do {

                                if let statusCode = response.response?.statusCode {
                                                if statusCode == 200 {
                                                    completion(.success("Verification code sent sucessfully"))

                                                } else  {
                                                    
                                                    completion(.success("Email not found"))

                                                }
                                
                                }
                        
                      
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
    
    
    
    func VerifyCodeOtp(request: VerifyCodeRequest, completion: @escaping (Result<ErrorResponse, Error>) -> ()) -> DataRequest {
        let url = "\(base_url)/user/reset"
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            var urlRequest = try URLRequest(url: url, method: .post)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedRequest
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            
                            let messageResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            completion(.success(messageResponse))
                            print(messageResponse)
                           
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

    
    func ResetPassword(request: ResetPasswordRequest, completion: @escaping (Result<ErrorResponse, Error>) -> Void) -> DataRequest {
    
        let url = "\(base_url)/user/change"
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            var urlRequest = try URLRequest(url: url, method: .post)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedRequest
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            do {
                                
                                let messageResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                                completion(.success(messageResponse))
                                print(messageResponse)
                               
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
