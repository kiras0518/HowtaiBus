//
//  NetworkManager.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/7.
//

import Foundation

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
    
    func getRequest(completion: @escaping (Result<BusModel2?, ManagerErrors>) -> Void) {
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
 
}
