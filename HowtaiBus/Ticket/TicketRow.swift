//
//  TicketRow.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/23.
//

import SwiftUI

struct TicketRow: View {
    
    @State var ticker: TicketModel
    
    var body: some View {
        HStack {
            Text(ticker.ticketType)
            Spacer()
            Text("\(String(ticker.sales)) 元")
                .foregroundColor(.secondary)
        }

    }
}

struct TicketRow_Previews: PreviewProvider {
    static var previews: some View {
        TicketRow(ticker: TicketModel(ticketType: "票種", sales: 0))
    }
}
