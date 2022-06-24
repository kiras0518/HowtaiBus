//
//  BusModel.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/7.
//

import Foundation

//"Schedule_day": "2022/06/07",
//"Schedule_Time": "14: 00", 出發時間
//"Car_No": "KKB-0176",
//"RouteName": "1新竹線",
//"GoBack": 2北上, 1南下
//"Guest_count": 8,
//"Chair": 35, 座位
//"IsMarked": 0,
//"Guest_Note": "已消毒", null
//"GPSLocation": "酒泉重慶路口0.1km(接近中)"

struct BusModel : Identifiable, Codable {
    var id = UUID()
    let schedule_day : String?
    let schedule_Time : String?
    let car_No : String?
    let routeName : String?
    let goBack : Int?
    let guest_count : Int?
    let chair : Int?
    let isMarked : Int?
    let guest_Note : String?
    let gPSLocation : String?

    init(schedule_day: String, schedule_Time: String, car_No: String, routeName: String, goBack: Int, guest_count: Int,
         chair: Int, isMarked: Int, guest_Note: String, gPSLocation: String) {
        self.schedule_day = schedule_day
        self.schedule_Time = schedule_Time
        self.car_No = car_No
        self.routeName = routeName
        self.goBack = goBack
        self.guest_count = guest_count
        self.chair = chair
        self.isMarked = isMarked
        self.guest_Note = guest_Note
        self.gPSLocation = gPSLocation
    }
    
    enum CodingKeys: String, CodingKey {

        case schedule_day = "Schedule_day"
        case schedule_Time = "Schedule_Time"
        case car_No = "Car_No"
        case routeName = "RouteName"
        case goBack = "GoBack"
        case guest_count = "Guest_count"
        case chair = "Chair"
        case isMarked = "IsMarked"
        case guest_Note = "Guest_Note"
        case gPSLocation = "GPSLocation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        schedule_day = try values.decodeIfPresent(String.self, forKey: .schedule_day)
        schedule_Time = try values.decodeIfPresent(String.self, forKey: .schedule_Time)
        car_No = try values.decodeIfPresent(String.self, forKey: .car_No)
        routeName = try values.decodeIfPresent(String.self, forKey: .routeName)
        goBack = try values.decodeIfPresent(Int.self, forKey: .goBack)
        guest_count = try values.decodeIfPresent(Int.self, forKey: .guest_count)
        chair = try values.decodeIfPresent(Int.self, forKey: .chair)
        isMarked = try values.decodeIfPresent(Int.self, forKey: .isMarked)
        guest_Note = try values.decodeIfPresent(String.self, forKey: .guest_Note)
        gPSLocation = try values.decodeIfPresent(String.self, forKey: .gPSLocation)
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
