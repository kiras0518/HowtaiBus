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
