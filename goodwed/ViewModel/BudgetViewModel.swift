import Foundation
import Alamofire

class BudgetViewModel: ObservableObject {
    @Published var budgets = [budget]()
    var budgetRequest: BudgetRequest?
    var errorMessage: String?
    
    
    init(){
        self.getBudgets()

    }
    
    func deleteBudget(id: String) {
        AF.request("http://172.17.0.237:9092/budget/\(id)", method: .delete).validate().response { [weak self] response in
            switch response.result {
            case .success:
                self?.budgets.removeAll { $0._id == id } // Remove the checklist from the array
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func AddBudget(request: BudgetRequest, completion: @escaping (Result<BudgetResponse, Error>) -> ()) -> DataRequest {
        let url = "http://172.17.0.237:9092/budget/user/642f9382de576283773909ba"
        
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
                            let budgetResponse = try JSONDecoder().decode(BudgetResponse.self, from: data)
                            completion(.success(budgetResponse))
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
     
    func getBudgets() {
        fetchBudget() { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                        case .success(let budgets):
                            self?.budgets = budgets
                            print(budgets)
                            
                        case .failure(let error):
                            print("error loading checklists: \(error)")
                            //self?.state = .error(error.localizedDescription)
                        }
            }
        }
    
    }
}

func fetchBudget( completion: @escaping(Result<[budget],APIError>) -> Void) {
    let url = URL(string : "http://172.17.0.237:9092/budget/user/642f9382de576283773909ba")
    //createURL(for:   .movie, page: nil, limit: nil)
    fetch1(type: [budget].self, url: url, completion: completion)
}

func fetch1<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T,APIError>) -> Void) {
    
    guard let url = url else {
        let error = APIError.badURL
        completion(Result.failure(error))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let error = error as? URLError {
            completion(Result.failure(APIError.urlSession(error)))
        } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            completion(Result.failure(APIError.badResponse(response.statusCode)))
        } else if let data = data {
            
            do {
                let result = try JSONDecoder().decode(type, from: data)
                completion(Result.success(result))
            } catch {
                completion(Result.failure(.decoding(error as? DecodingError)))
            }
        }
    }.resume()
}
