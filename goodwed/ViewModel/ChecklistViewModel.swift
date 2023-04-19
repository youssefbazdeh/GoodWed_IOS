import Foundation
import Alamofire

class ChecklistViewModel: ObservableObject {
    @Published var nom: String = ""
    @Published var type: String = ""
    @Published var note: String = ""
    @Published var status: String = ""
    @Published var date: String = ""
    @Published var imageData: Data?
    @Published var checklists = [checklist]()
    
    var checklistRequest: ChecklistRequest?
    var errorMessage: String?
    
    init(){
        self.getChecklists()

    }
    
    func deleteChecklist(id: String) {
        AF.request("http://172.17.0.237:9092/checklist/\(id)", method: .delete).validate().response { [weak self] response in
            switch response.result {
            case .success:
                self?.checklists.removeAll { $0._id == id } // Remove the checklist from the array
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func AddChecklist(nom: String, type: String, note: String, image: UIImage, date: String, status: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert UIImage to Data")
            return
        }
        self.nom = nom
        self.type = type
        self.note = note
        self.date = date
        self.status = status
        self.imageData = imageData
        
        let headers: HTTPHeaders = ["Content-type": "application/x-www-form-urlencoded"]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            multipartFormData.append(Data(nom.utf8), withName: "nom")
            multipartFormData.append(Data(type.utf8), withName: "type")
            multipartFormData.append(Data(note.utf8), withName: "note")
            multipartFormData.append(Data(date.utf8), withName: "date")
            multipartFormData.append(Data(status.utf8), withName: "status")
        }, to: "http://172.17.0.237:9092/checklist/user/642f9382de576283773909ba", method: .post, headers: headers, interceptor: nil, fileManager: FileManager(), requestModifier: nil)
        .validate()
        .response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func getChecklists() {
        fetchChecklists() { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                        case .success(let checklists):
                            self?.checklists = checklists
                            print(checklists)
                            
                        case .failure(let error):
                            print("error loading checklists: \(error)")
                            //self?.state = .error(error.localizedDescription)
                        }
            }
        }
    
    }

}


func fetchChecklists( completion: @escaping(Result<[checklist],APIError>) -> Void) {
    let url = URL(string : "http://172.17.0.237:9092/checklist/user/642f9382de576283773909ba")
    //createURL(for:   .movie, page: nil, limit: nil)
    fetch(type: [checklist].self, url: url, completion: completion)
}

func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T,APIError>) -> Void) {
    
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
    
    /*func AddChecklist(request: ChecklistRequest, completion: @escaping (Result<ChecklistResponse, Error>) -> ()) -> DataRequest {
        let url = "http://192.168.31.33:9092/checklist/user/642f9382de576283773909ba"
        
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
                            let checklistRespone = try JSONDecoder().decode(ChecklistResponse.self, from: data)
                            completion(.success(checklistRespone))
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
    }*/

enum APIError: Error, CustomStringConvertible {
    
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
            case .badURL:
                return "badURL"
            case .urlSession(let error):
                return "urlSession error: \(error.debugDescription)"
            case .badResponse(let statusCode):
                return "bad response with status code: \(statusCode)"
            case .decoding(let decodingError):
                return "decoding error: \(decodingError)"
            case .unknown:
                return "unknown error"
        }
    }
    
    var localizedDescription: String {
        switch self {
            case .badURL, .unknown:
               return "something went wrong"
            case .urlSession(let urlError):
                return urlError?.localizedDescription ?? "something went wrong"
            case .badResponse(_):
                return "something went wrong"
            case .decoding(let decodingError):
                return decodingError?.localizedDescription ?? "something went wrong"
        }
    }
}




