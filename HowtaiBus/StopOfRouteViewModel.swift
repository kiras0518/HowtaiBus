//
//  StopOfRouteViewModel.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/28.
//

import Foundation
import Combine

class StopOfRouteViewModelV2: ObservableObject {
    
    @Published var model: [StopOfRouteModel] = []
    
    private var cancellable: AnyCancellable?
    
    func fetchAPI() {
        cancellable = NetworkManager.shared.getStopOfRouteData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                   
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { res in
               
                self.model = res
                //print("StopOfRouteViewModelV2:", res ,res.count)
            }
    }
}

class StopOfRouteViewModel: ObservableObject {
    
    @Published var model: [StopOfRouteModel] = []

    func fetchAPIV2() {
        guard let url = URL(string: "https://ticp.motc.gov.tw/motcTicket/api/StopOfRoute/InterCity/Operator/1405?$format=json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decoder = try JSONDecoder().decode([StopOfRouteModel].self, from: data)
                
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
    
    func fetchAPI() {
        
        NetworkManager.shared.getTDXRequest { result in
            switch result {
                
            case .success(let modelList):
              
                self.model = modelList ?? []
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
