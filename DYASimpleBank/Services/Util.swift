//
//  Util.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 25/11/21.
//

import Foundation

let strategyDate = Date.ParseStrategy(format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)T\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits):\(second: .twoDigits)\(timeZone: .iso8601(.short))", timeZone: .current)
