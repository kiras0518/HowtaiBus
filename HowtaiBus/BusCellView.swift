//
//  BusCellView.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/7.
//

import SwiftUI

struct BusCellView: View {
    
    @State var busModel: BusModelV2
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 8) {
            
            ZStack {
                Image("bus")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
            }
            
            VStack(alignment: .leading, spacing: 8) {
                //.font(.subheadline.weight(.medium))
                //.foregroundStyle(.tertiary)
                HStack {
                    Text("車號:")
                    Text(busModel.car_No ?? "")
                        .font(.title2)
                }
                
                HStack {
                    Text("時間:")
                    Text(String(busModel.schedule_Time ?? ""))
                }
                
                HStack {
                    Text("位置:")
                    Text(busModel.gPSLocation ?? "")
                    //.layoutPriority(8)
                }
                
                HStack {
                    Text("座位數量:")
                    Text(String(busModel.chair ?? -1))
                }
                
                Text(busModel.guest_Note ?? "")
                    .foregroundColor(.blue)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            //.labelStyle(RecommendedSpotSummaryLabelStyle())
            
        }
        
        .padding()
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        
    }
}

struct BusCellView_Previews: PreviewProvider {
    static var previews: some View {
        
        BusCellView(busModel: BusModelV2(schedule_day: "2022/06/16", schedule_Time: "15: 30", car_No: "ABC-123", routeName: "1新竹線", goBack: 0, guest_count: 2, chair: 30, isMarked: 0, guest_Note: "未消毒", gPSLocation: "台北圓環南京西路0.3km(接近中)"))
    }
}

struct RecommendedSpotSummaryLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.system(size: 18))
                .imageScale(.large)
                .frame(width: 30, height: 30)
                .foregroundStyle(.secondary)
            configuration.title
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
    }
}
