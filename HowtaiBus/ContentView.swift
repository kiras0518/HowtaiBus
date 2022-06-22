//
//  ContentView.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/7.
//

import SwiftUI
import Combine

enum FilterType: Int {
    case north = 1
    case south = 2
}

struct ContentView: View {
    
    @ObservedObject var vm = BusViewModel()
    @ObservedObject var vm2 = BusViewModelV2()
    
    @State private var selectedIndex = 0
    @State private var currentProgress = 0.0
    
    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Picker("Selected Bus", selection: $selectedIndex, content: {
                    Text("北上").tag(0)
                    Text("南下").tag(1)
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ProgressView(value: currentProgress,
                             total: 300)
                .accentColor(.accentColor)
                    .padding()
                    .onReceive(timer) { time in
                        
                        if currentProgress < 300 {
                            currentProgress += 1
                            //print("The time is now \(time)")
                        } else {
                            currentProgress = 0
                            //updata API
                            vm.fetchAPI()
                        }
                    }
                
                if self.selectedIndex == 0 {
                    
                    let north = vm.filterContent(byType: .north)
                    
                    List(vm.filteredModel) { res in
                        BusCellView(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                    }
                    
                } else {
                    
                    let south = vm.filterContent(byType: .south)
                    
                    List(vm.filteredModel) { res in
                        BusCellView(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                            //.foregroundColor(.red)
                    }
                }
                
            }
            
            .navigationTitle("🔥Hello Bus🔥")
            .onAppear(perform: {
                print("contentView appeared!")

                vm.fetchAPI()
                UITableView.appearance().separatorStyle = .none
            })
            .onDisappear {
                print("contentView disappeared!")
               
            }
//            .task {
//                await vm.fetchAPI()
//            }
          
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
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
