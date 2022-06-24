//
//  ContentView.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/7.
//

import SwiftUI
import Combine

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
                    Text("中華線").tag(2)
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
                        vm.fetchAPI(routeId: 1)
                        vm2.fetchAPI()
                    }
                }
                
                if self.selectedIndex == 0 {
                    
                    let filter = vm.model.filter({$0.goBack == FilterType.north.rawValue})
                    
                    List(filter) { res in
                        BusRow(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                       
                    }
                    
                    BannerVC()
                    
                } else if self.selectedIndex == 1 {
                    
                    let filter = vm.model.filter({$0.goBack == FilterType.south.rawValue})
                    
                    List(filter) { res in
                        BusRow(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                    }
                    
                    BannerVC()
                    
                } else if self.selectedIndex == 2 {
                    
                    if vm2.isRequestFailed {
                        Spacer()
                        Text("❗️暫時無發車❗️")
                            .font(.system(size: 36))
                            .padding()
                    } else {
                        List(vm2.model) { res in
                            BusRow(busModel: res)
                                .shadow(radius: 4)
                                .padding(0)
                            //.foregroundColor(.red)
                        }
                    }
                    
                    BannerVC()
                }
                
                Spacer()
                
            }
            
            .navigationTitle("🚌豪泰搭車GO🚌")
            .onAppear(perform: {
                print("contentView appeared!")
                
                vm.fetchAPI(routeId: 1)
                vm2.fetchAPI()
                
                UITableView.appearance().separatorStyle = .none
            })
            .onDisappear {
                print("contentView disappeared!")
                
            }
            //.task {
            // await vm.fetchAPI(type: 1)
            //}
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
