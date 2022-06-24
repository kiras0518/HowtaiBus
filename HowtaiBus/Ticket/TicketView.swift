//
//  TicketView.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/23.
//

import SwiftUI

struct TicketView: View {
    
    var ticket2011Data = [TicketModel(ticketType: "優惠票", sales: 140),
                      TicketModel(ticketType: "半票", sales: 77),
                      TicketModel(ticketType: "來回票(2張)", sales: 260),
                      TicketModel(ticketType: "回數票(10張)", sales: 1200),
                      TicketModel(ticketType: "定期票(40張)", sales: 4200),
                      TicketModel(ticketType: "學生票", sales: 110)
    ]
    
    var ticket2011BData = [TicketModel(ticketType: "優惠票", sales: 150),
                      TicketModel(ticketType: "半票", sales: 79),
                      TicketModel(ticketType: "回數票(10張)", sales: 1300)
    ]
    
    var ticket2011CData = [TicketModel(ticketType: "優惠票", sales: 150),
                      TicketModel(ticketType: "半票", sales: 79),
                      TicketModel(ticketType: "回數票(10張)", sales: 1300),
                      TicketModel(ticketType: "南大門優惠票", sales: 120)
    ]
    
    var ticketTipData = [TicketModel(ticketType: "台北端 23:30 後優惠票回復為全票原價", sales: 150),
                      TicketModel(ticketType: "新竹端 22:40 後優惠票回復為全票原價", sales: 150)
    ]
    
    var body: some View {
        
        NavigationView {
            List {
                
                Section {
                    ForEach(ticket2011Data) { datum in
                        TicketRow(ticker: datum)
                    }
                } header: {
                    Text("【2011】台北市 - 新竹轉運站")
                        .font(.system(size: 20))
                        .bold()
                }
                
                Section {
                    ForEach(ticket2011BData) { datum in
                        TicketRow(ticker: datum)
                    }
                } header: {
                    Text("【2011B】台北市 - 新竹香山牧場")
                        .font(.system(size: 20))
                        .bold()
                }
                
                Section {
                    ForEach(ticket2011CData) { datum in
                        TicketRow(ticker: datum)
                    }
                } header: {
                    Text("【2011】台北市 - 新竹轉運站")
                        .font(.system(size: 20))
                        .bold()
                }
                
                Section {
                    ForEach(ticketTipData) { datum in
                        TicketRow(ticker: datum)
                    }
                } header: {
                    Text("【注意事項】")
                        .font(.system(size: 20))
                        .bold()
                }
                
            }
            .navigationTitle("票價表")
            .onAppear(perform: {
                print("TicketView appeared!")
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
