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
                
                //Spacer()
                
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
                    
                    let filter = vm.model.filter({$0.goBack == 1})
                    
                    List(filter) { res in
                        BusRow(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                    }
                    
                } else if self.selectedIndex == 1 {
                    
                    let filter = vm.model.filter({$0.goBack == 2})
                    
                    List(filter) { res in
                        BusRow(busModel: res)
                            .shadow(radius: 4)
                            .padding(0)
                    }
                    
                } else if self.selectedIndex == 2 {
                    
                    if vm2.isRequestFailed {
                        Text("暫時無發車")
                    } else {
                        List(vm2.model) { res in
                            BusRow(busModel: res)
                                .shadow(radius: 4)
                                .padding(0)
                            //.foregroundColor(.red)
                        }
                    }
                    
                }
                
                Spacer()
                
            }
            
            .navigationTitle("🔥Hello Bus🔥")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
