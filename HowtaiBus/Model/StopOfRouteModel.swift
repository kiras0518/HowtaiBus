//
//  StopOfRouteModel.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/28.
//

import Foundation

struct StopOfRouteModel : Codable {
    let routeUID : String?
    let routeID : String?
    let routeName : RouteName?
    let operators : [Operators]?
    let subRouteUID : String?
    let subRouteID : String?
    let subRouteName : SubRouteName?
    let direction : Int?
    let stops : [Stops]?

    enum CodingKeys: String, CodingKey {

        case routeUID = "RouteUID"
        case routeID = "RouteID"
        case routeName = "RouteName"
        case operators = "Operators"
        case subRouteUID = "SubRouteUID"
        case subRouteID = "SubRouteID"
        case subRouteName = "SubRouteName"
        case direction = "Direction"
        case stops = "Stops"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        routeUID = try values.decodeIfPresent(String.self, forKey: .routeUID)
        routeID = try values.decodeIfPresent(String.self, forKey: .routeID)
        routeName = try values.decodeIfPresent(RouteName.self, forKey: .routeName)
        operators = try values.decodeIfPresent([Operators].self, forKey: .operators)
        subRouteUID = try values.decodeIfPresent(String.self, forKey: .subRouteUID)
        subRouteID = try values.decodeIfPresent(String.self, forKey: .subRouteID)
        subRouteName = try values.decodeIfPresent(SubRouteName.self, forKey: .subRouteName)
        direction = try values.decodeIfPresent(Int.self, forKey: .direction)
        stops = try values.decodeIfPresent([Stops].self, forKey: .stops)
    }

}

struct OperatorName : Codable {
    let zh_tw : String?
    let en : String?

    enum CodingKeys: String, CodingKey {

        case zh_tw = "Zh_tw"
        case en = "En"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        zh_tw = try values.decodeIfPresent(String.self, forKey: .zh_tw)
        en = try values.decodeIfPresent(String.self, forKey: .en)
    }

}

struct Operators : Codable {
    let operatorID : String?
    let operatorName : OperatorName?
    let operatorCode : String?
    let operatorNo : String?

    enum CodingKeys: String, CodingKey {

        case operatorID = "OperatorID"
        case operatorName = "OperatorName"
        case operatorCode = "OperatorCode"
        case operatorNo = "OperatorNo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        operatorID = try values.decodeIfPresent(String.self, forKey: .operatorID)
        operatorName = try values.decodeIfPresent(OperatorName.self, forKey: .operatorName)
        operatorCode = try values.decodeIfPresent(String.self, forKey: .operatorCode)
        operatorNo = try values.decodeIfPresent(String.self, forKey: .operatorNo)
    }

}

struct RouteName : Codable {
    let zh_tw : String?
    let en : String?

    enum CodingKeys: String, CodingKey {

        case zh_tw = "Zh_tw"
        case en = "En"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        zh_tw = try values.decodeIfPresent(String.self, forKey: .zh_tw)
        en = try values.decodeIfPresent(String.self, forKey: .en)
    }

}

struct StopName : Codable {
    let zh_tw : String?
    let en : String?

    enum CodingKeys: String, CodingKey {

        case zh_tw = "Zh_tw"
        case en = "En"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        zh_tw = try values.decodeIfPresent(String.self, forKey: .zh_tw)
        en = try values.decodeIfPresent(String.self, forKey: .en)
    }

}

struct StopPosition : Codable {
    let positionLat : Double?
    let positionLon : Double?

    enum CodingKeys: String, CodingKey {

        case positionLat = "PositionLat"
        case positionLon = "PositionLon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        positionLat = try values.decodeIfPresent(Double.self, forKey: .positionLat)
        positionLon = try values.decodeIfPresent(Double.self, forKey: .positionLon)
    }

}

struct Stops : Codable {
    let stopUID : String?
    let stopID : String?
    let stopName : StopName?
    let stopBoarding : Int?
    let stopSequence : Int?
    let stopPosition : StopPosition?
    let stationID : String?
    let locationCityCode : String?

    enum CodingKeys: String, CodingKey {

        case stopUID = "StopUID"
        case stopID = "StopID"
        case stopName = "StopName"
        case stopBoarding = "StopBoarding"
        case stopSequence = "StopSequence"
        case stopPosition = "StopPosition"
        case stationID = "StationID"
        case locationCityCode = "LocationCityCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        stopUID = try values.decodeIfPresent(String.self, forKey: .stopUID)
        stopID = try values.decodeIfPresent(String.self, forKey: .stopID)
        stopName = try values.decodeIfPresent(StopName.self, forKey: .stopName)
        stopBoarding = try values.decodeIfPresent(Int.self, forKey: .stopBoarding)
        stopSequence = try values.decodeIfPresent(Int.self, forKey: .stopSequence)
        stopPosition = try values.decodeIfPresent(StopPosition.self, forKey: .stopPosition)
        stationID = try values.decodeIfPresent(String.self, forKey: .stationID)
        locationCityCode = try values.decodeIfPresent(String.self, forKey: .locationCityCode)
    }

}

struct SubRouteName : Codable {
    let zh_tw : String?
    let en : String?

    enum CodingKeys: String, CodingKey {

        case zh_tw = "Zh_tw"
        case en = "En"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        zh_tw = try values.decodeIfPresent(String.self, forKey: .zh_tw)
        en = try values.decodeIfPresent(String.self, forKey: .en)
    }

}
