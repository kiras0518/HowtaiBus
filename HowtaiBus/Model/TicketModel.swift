//
//  TicketModel.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/23.
//

import Foundation

struct TicketModel: Identifiable, Equatable {
    
    var id = UUID()
    let ticketType: String
    let sales: Int
    
    init(ticketType: String, sales: Int) {
        self.ticketType = ticketType
        self.sales = sales
    }
}
