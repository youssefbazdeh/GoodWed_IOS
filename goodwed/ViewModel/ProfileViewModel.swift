//
//  ProfileViewModel.swift
//  App-IOS
//
//  Created by Bilel Ouerghi on 14/4/2023.
//

import Alamofire




class ProfileViewModel: ObservableObject {
    
    @Published var newsList: [news] = []

    @Published var user: User?
    @Published var errorMessage: String = ""
    let accessToken = UserDefaults.standard.string(forKey: "accessToken")
    let accessToken1 = UserDefaults.standard.string(forKey: "accessToken")!

    func fetchUser() {
            let url = "\(base_url)/user/profile"
            
          
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken1)",
                "Content-Type": "application/json"
            ]
            
            AF.request(url, headers: headers)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseDecodable(of: User.self) { response in
                    switch response.result {
                    case .success(let user):
                        self.user = user
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
        }
    
    
    func updateUser(request: UpdateUserRequest, completion: @escaping () -> Void) {
        let url = "\(base_url)/user/profile"
       
      
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken1)", "Content-Type": "application/json"        ]
        
        AF.request(url, method: .put, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success(_):
                    completion()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
    }
    
       
       func fetchNews() {
           let url = "\(base_url)/news/news"
           
           AF.request(url)
               .validate(statusCode: 200..<300)
               .validate(contentType: ["application/json"])
               .responseDecodable(of: [news].self) { response in
                   switch response.result {
                   case .success(let news):
                       self.newsList = news
                   case .failure(let error):
                       self.errorMessage = error.localizedDescription
                       print("error newssss")
                   }
               }
       }
       

}
