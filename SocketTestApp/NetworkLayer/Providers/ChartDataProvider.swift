//
//  ChartDataProvider.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 19.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import Foundation
import RxSwift

class ChartDataProvider {
    let networkCore = NetworkCore()
    let disposeBag = DisposeBag()
    let tickerSubject = PublishSubject<Ticker>()
    
    init() {
       tryToConnect()
    }
    
    func tryToConnect() {
        networkCore.connect().subscribe(onNext: { isConnected in
            if isConnected {
                self.connectToChannel()
            }
        }, onError: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
    
    func connectToChannel() {
        let dict = ["event": "subscribe",
                    "channel": "ticker",
                    "pair": "BTCUSD"]
        let data = try? JSONEncoder().encode(dict)
        guard
            let newData = data,
            let string = String.init(data: newData, encoding: .utf8)
            else {
                return
        }
        networkCore.post(data: string)
        bindToResponse()
    }
    
    func bindToResponse() {
        networkCore.stringResponseSubject.subscribe(onNext: { string in
            guard let ticker = Ticker.create(from: string) else {
                return
            }
            self.tickerSubject.onNext(ticker)
        })
        .disposed(by: disposeBag)
    }
}
