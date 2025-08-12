//
//  TDTimer.swift
//  TDAnalysis
//
//  Created by fench on 2024/2/26.
//

import Foundation
import Dispatch

@objc public class TDTimer: NSObject {
    static let shared: TDTimer = TDTimer()
    
    var timerList: [String: DispatchSourceTimer] = [:]
}

@objc public extension TDTimer {
    @objc
    /// 开启定时器
    /// - Parameters:
    ///   - key: 定时器 ID
    ///   - interval: 定时器的间隔时间
    ///   - repeats: repeats 是否重复 默认为 true
    ///   - action: 回调
    public static func startTimer(with key: String, interval: TimeInterval, repeats: Bool = true, action: @escaping Block.VoidBlock) {
        shared.startTimer(key, interval: interval, repeats: repeats, action: action)
    }
    
    @objc
    /// 停止定时器
    /// - Parameter key: 定时器的 ID
    public static func stopTimer(for key:String) {
        shared.stopTimer(key)
    }
}

extension TDTimer {
    
    func hasTimer(_ key: String) -> Bool {
        return timerList.keys.contains(key)
    }
    
    func startTimer(_ key: String, interval: TimeInterval, repeats: Bool, action: @escaping Block.VoidBlock) {
        if key.isEmpty {
            return
        }
        
        let timer: DispatchSourceTimer
        if let t = timerList[key] {
            timer = t
        } else {
            timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
            timer.resume()
            timerList[key] = timer
        }
        timer.schedule(deadline: .now(), repeating: .milliseconds(Int(interval * 1000)), leeway: .milliseconds(100))
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            action()
            if !repeats {
                self.stopTimer(key)
            }
        }
    }
    
    func stopTimer(_ key: String) {
        guard let timer = timerList[key] else { return }
        timer.cancel()
        timerList.removeAll(keys: [key])
    }
    
    func cancelAll(){
        timerList.values.forEach { timer in
            timer.cancel()
        }
        timerList.removeAll()
    }
}
