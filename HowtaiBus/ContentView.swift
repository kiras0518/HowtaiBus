//
//  ContentView.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/7.
//

import SwiftUI

enum FilterType: Int {
    case north = 1
    case south = 2
}

struct ContentView: View {
    
    @ObservedObject var vm = BusViewModel()
    @State private var selectedIndex = 0
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Picker("Selected Bus", selection: $selectedIndex, content: {
                    Text("北上").tag(0)
                    Text("南下").tag(1)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                if self.selectedIndex == 0 {
                    
                    let messagesToDisplay = vm.filterContent(byType: .north)
                 
                    List(vm.filteredModel) { res in
                        BusCellView(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                    }
                } else {
                    
                    let messagesToDisplay = vm.filterContent(byType: .south)
                    
                    List(vm.filteredModel) { res in
                        BusCellView(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                            .foregroundColor(.red)
                    }
                }
                
            }
            
            .navigationTitle("🔥Hello Bus🔥")
            .onAppear(perform: {
                print("contentView appeared!")
                //vm.filterContent(byType: .south)
                UITableView.appearance().separatorStyle = .none
            })
            .onDisappear {
                print("contentView disappeared!")
            }
            .task {
                await vm.fetchAPI()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class BusViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var model: [BusModel2] = []
    @Published var filteredModel: [BusModel2] = []
 
    func fetchAPI() async {
        guard let url = URL(string: "http://www.howtai.com.tw/ApiRealTimeScheduleRun.aspx?RouteId=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decoder = try JSONDecoder().decode([BusModel2].self, from: data)
                
                DispatchQueue.main.async {
                    self.model = decoder
                    self.filteredModel = self.model
                    //print(self.filteredModel)
//                    let dataN = self.filteredModel.filter({$0.goBack == 1})
                    //print(dataN)
                }
                
            } catch {
                print("Failed to reach: \(error)")
            }
        }
        
        task.resume()
        
    }
    
    func filterContent(byType: FilterType) {

        //let dataN = filteredModel.filter({$0.goBack == 1})
        //let dataS = filteredModel.filter({$0.goBack == 2})
        
      
//        print("dataS1", dataS)
        
        switch byType {
        case .north:
            
            _ = filteredModel.filter({$0.goBack == 1})
            print("filteredModel1", filteredModel.count)
    //        print("dataN1", dataN)
        case .south:
            
            _ = filteredModel.filter({$0.goBack == 2})
            print("filteredModel2", filteredModel.count)
    //        print("dataN1", dataN)
        }
        
    }
    
}

struct FilterData: Identifiable {
    var id = UUID()
    let schedule_day : String
    let schedule_Time : String
    let car_No : String
    let routeName : String
    let goBack : Int
    let guest_count : Int
    let chair : Int
    let isMarked : Int
    let guest_Note : String
    let gPSLocation : String
}

class FilterModel: ObservableObject {
    @Published var data: [BusModel2] = []
    
    func filterContent() {
        
    }
    
}
