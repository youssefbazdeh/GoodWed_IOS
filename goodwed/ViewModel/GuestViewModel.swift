import Foundation
import Alamofire

class GuestViewModel: ObservableObject {
    @Published var guests = [guest]()
    var guestRequest: GuestRequest?
    var errorMessage: String?
    
    init(){
        self.getGuests()

    }
    
    func deleteGuestet(id: String) {
        AF.request("http://172.17.0.237:9092/guest/\(id)", method: .delete).validate().response { [weak self] response in
            switch response.result {
            case .success:
                self?.guests.removeAll { $0._id == id } // Remove the checklist from the array
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func AddGuestt(request: GuestRequest, completion: @escaping (Result<GuestResponse, Error>) -> ()) -> DataRequest {
        let url = "http://172.17.0.237:9092/guest/user/642f9382de576283773909ba"
        
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
                            let guestResponse = try JSONDecoder().decode(GuestResponse.self, from: data)
                            completion(.success(guestResponse))
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
    
    func getGuests() {
        fetchGuest() { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                        case .success(let guests):
                            self?.guests = guests
                            print(guests)
                            
                        case .failure(let error):
                            print("error loading checklists: \(error)")
                            //self?.state = .error(error.localizedDescription)
                        }
            }
        }
    
    }
    
}


func fetchGuest( completion: @escaping(Result<[guest],APIError>) -> Void) {
    let url = URL(string : "http://172.17.0.237:9092/guest/user/642f9382de576283773909ba")
    //createURL(for:   .movie, page: nil, limit: nil)
    fetch2(type: [guest].self, url: url, completion: completion)
}

func fetch2<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T,APIError>) -> Void) {
    
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
