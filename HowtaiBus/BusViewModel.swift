//
//  BusViewModel.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/22.
//

import SwiftUI
import Combine

enum FilterType: Int {
    case north = 2
    case south = 1
}

class BusViewModelV2: ObservableObject {
    
    @Published var model: [BusModel] = []
    @Published var isRequestFailed = false
    private var cancellable: AnyCancellable?
    
    func fetchAPI() {
        cancellable = NetworkManager.shared.getBusData(routeId: 3)
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
                //self.model.append(contentsOf: res)
                self.model = res
                //print("getData:", res ,res.count)
            }
    }
}

class BusViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var model: [BusModel] = []
    var filteredModel: [BusModel] = []
    
    func fetchAPI(routeId: Int) {
        guard let url = URL(string: "http://www.howtai.com.tw/ApiRealTimeScheduleRun.aspx?RouteId=\(routeId)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decoder = try JSONDecoder().decode([BusModel].self, from: data)
                
                DispatchQueue.main.async {
                    self.model = decoder
                }
                //print(self.model)
            } catch {
                print("Failed to reach: \(error)")
            }
        }
        
        task.resume()
    }
    
    func filterContent(byType: FilterType) -> [BusModel] {
        
        let filterNorth = model.filter({$0.goBack == FilterType.north.rawValue})
        let filterSouth = model.filter({$0.goBack == FilterType.south.rawValue})
        
        switch byType {
        case .north:
            print("dataN", filterNorth.count)
            filteredModel = filterNorth
   
        case .south:
            print("dataS", filterSouth.count)
            filteredModel = filterSouth
        }
        
        return filteredModel
        
    }
    
}
