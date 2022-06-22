//
//  BusViewModel.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/22.
//

import SwiftUI
import Combine

enum FilterType: Int {
    case north = 1
    case south = 2
}

class BusViewModelV2: ObservableObject {
    
    @Published var model: [BusModelV2] = []
    @Published var isRequestFailed = false
    private var cancellable: AnyCancellable?
    
    func fetchAPI() {
        cancellable = NetworkManager.shared.getData(routeId: 1)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.isRequestFailed = true
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { res in
                self.model.append(contentsOf: res)
                //print("getData:", res ,res.count)
            }
    }
}

class BusViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var model: [BusModelV2] = []
    var filteredModel: [BusModelV2] = []
    
    func fetchAPI() {
        guard let url = URL(string: "http://www.howtai.com.tw/ApiRealTimeScheduleRun.aspx?RouteId=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decoder = try JSONDecoder().decode([BusModelV2].self, from: data)
                
                DispatchQueue.main.async {
                    self.model = decoder
                }

            } catch {
                print("Failed to reach: \(error)")
            }
        }
        
        task.resume()
        
    }
    
    func filterContent(byType: FilterType) {
        
        let dataN = model.filter({$0.goBack == 1})
        let dataS = model.filter({$0.goBack == 2})
        
        switch byType {
        case .north:
            print("dataN", dataN.count)
            filteredModel = dataN
   
        case .south:
            print("dataS", dataS.count)
            filteredModel = dataS
        }
        
    }
    
}
