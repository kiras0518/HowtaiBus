//
//  NetworkManager.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/7.
//

import Foundation
import Combine

enum ManagerErrors: String, Error {
    case invalidData = "the data received from the server was invlaid. Please try again."
    case invalidRequest = "The endpoint request to get venues is invalid."
    case invalidJSON = "JSON is invalid."
}

class NetworkManager {
    
    //建議讀取頻率為30秒以上
    //新竹線 http://www.howtai.com.tw/ApiRealTimeScheduleRun.aspx?RouteId=1
    //中華線 http://www.howtai.com.tw/ApiRealTimeScheduleRun.aspx?RouteId=3
    
    static let shared = NetworkManager()
    
    let baseURL = "http://www.howtai.com.tw/ApiRealTimeScheduleRun.aspx?RouteId="
    
    func getRequest(completion: @escaping (Result<BusModelV2?, ManagerErrors>) -> Void) {
        let url = baseURL + "1"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (Result<T?, ManagerErrors>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion(.failure(.invalidRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.invalidJSON))
            }
            
        }
        task.resume()
    }
    
    func getData(routeId: Int = 1) -> AnyPublisher<[BusModelV2], Error> {
        // 2
     //   var components = URLComponents(string: "https://api.github.com/users")!
//        components.queryItems = [
//            URLQueryItem(name: "per_page", value: "\(perPage)"),
//            URLQueryItem(name: "since", value: (sinceId != nil) ? "\(sinceId!)" : nil)
//        ]
        
        let components = URLComponents(string: "http://www.howtai.com.tw/ApiRealTimeScheduleRun.aspx?RouteId=\(routeId)")!
        
        // 3
        let request = URLRequest(url: components.url!, timeoutInterval: 10)
        // 4
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [BusModelV2].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
