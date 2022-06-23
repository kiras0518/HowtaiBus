//
//  MainView.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      
        TabView {
            ContentView()
              .tabItem {
                Image(systemName: "bus")
                Text("Bus")
              }
            
            TicketView()
              .tabItem {
                Image(systemName: "ticket")
                Text("Ticket")
              }
            
            TicketView()
              .tabItem {
                Image(systemName: "info.circle")
                Text("Info")
              }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
