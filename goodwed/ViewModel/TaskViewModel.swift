//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by OmarKaabi on 8/5/2023.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var storedTasks : [checklist] = []
    
    @Published var currentWeek : [Date] = []
    
    @Published var currentDay: Date = Date()
    
    @Published var filteredTasks: [checklist]?
    
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
        getTasks()
        print(storedTasks.count)
    }
    
    func getTasks() {
        fetchTasks() { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                        case .success(let checklists):
                            self?.storedTasks = checklists
                            print(checklists)
                            
                        case .failure(let error):
                            print("error loading checklists: \(error)")
                            //self?.state = .error(error.localizedDescription)
                        }
            }
        }

    }
    
    func formatDate(date: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date) ?? Date(timeIntervalSinceReferenceDate: 0)
    
    }
    
    func filterTodayTasks(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: $0.date) ?? Date(timeIntervalSinceReferenceDate: 0)
                return calendar.isDate(date, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date,format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func isCurrentHour(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
    
}


func fetchTasks( completion: @escaping(Result<[checklist],APIError>) -> Void) {
    let url = URL(string : "\(base_url)/checklist/user/642f9382de576283773909ba")
    //createURL(for:   .movie, page: nil, limit: nil)
    fetch(type: [checklist].self, url: url, completion: completion)
}

func fetcht<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T,APIError>) -> Void) {
    
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
                let dateFormatter = DateFormatter()
         
                
                let result = try JSONDecoder().decode(type, from: data)
                completion(Result.success(result))
            } catch {
                completion(Result.failure(.decoding(error as? DecodingError)))
            }
        }
    }.resume()
}
