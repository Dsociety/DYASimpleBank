//
//  Print&LogServices.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 18/08/21.
//

import Foundation
import os


//MARK: Loggers
let apilogger = Logger(subsystem: "com.bydemes.tssInstaller", category: "iunoniApiRepository")
let appLogger = Logger(subsystem: "com.bydemes.tssInstaller", category: "appInternalFunc")
//TODO: ADD Sentry o Firebase like external logger here.


enum PrintType{
    case notice, success, error, fault, critical
}


enum LoggersType{
    case null, apiLogger, appLogger
}


//Print screen in debug and print log in production
func print(_ items: String..., type: PrintType = .notice, withLogger logger: LoggersType = .null, filename: String = #file, function : String = #function, line: Int = #line, separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let exitLog = exitLogString(items: items, printType: type, separator: separator)
        Swift.print(exitLog, terminator: terminator)
    
    #else
    switch logger {
    case .null:
        break
    case .apiLogger:
        let exitLog = exitLogString(items: items, printType: type, separator: separator)
        
        switch type {
        case .notice:
            appLogger.info("\(exitLog)")
        case .success:
            appLogger.log("\(exitLog)")
        case .error:
            appLogger.error("\(exitLog)")
        case .fault:
            appLogger.fault("\(exitLog)")
        case .critical:
            appLogger.critical("\(exitLog)")
            
        }
        
    case .appLogger:
        let exitLog = exitLogString(items: items, printType: type, separator: separator)
        
        switch type {
        case .notice:
            apilogger.info("\(exitLog)")
        case .success:
            apilogger.log("\(exitLog)")
        case .error:
            apilogger.error("\(exitLog)")
        case .fault:
            apilogger.fault("\(exitLog)")
        case .critical:
            apilogger.critical("\(exitLog)")
        }
    }
    #endif
}


private func exitLogString(items: Any..., printType: PrintType = .notice, filename: String = #file, function : String = #function, line: Int = #line, separator: String = " ")-> String{
    let emojiLevel: String
    switch printType {
    case .notice:
        emojiLevel = "✏️"
    case .success:
        emojiLevel = "✅ "
    case .error:
        emojiLevel = "🔴 "
    case .fault:
        emojiLevel = "🔥 "
    case .critical:
        emojiLevel = "🔥🔥🔥 "
    }
    
    let pretty = "\(URL(fileURLWithPath: filename).lastPathComponent) [#\(line)] \(function)\n\t-> "
    let output = items.map { "\($0)" }.joined(separator: separator)
    
    return emojiLevel+pretty+output
}
