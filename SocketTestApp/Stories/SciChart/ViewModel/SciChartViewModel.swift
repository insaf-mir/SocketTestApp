//
//  SciChartViewModel.swift
//  SocketTestApp
//
//  Created by Insaf Mukhametshin on 23/11/2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import RxSwift
import RxCocoa
import SciChart

class SciChartViewModel {
    let disposeBag = DisposeBag()
    let provider = ChartDataProvider()
    
    let visiblePartVariable = BehaviorRelay<NSRange>(value: NSRange(location: 0, length: 0))
    let lineData = SCIXyDataSeries(xType: .double, yType: .double)

    private var tickers: [Ticker] = []
    private var tickersVariable = BehaviorRelay<[Ticker]>(value: [])
    private let visibleCapacity = 10
    init() {
        bind()
    }
    
    func bind() {
        provider.tickerSubject
            .subscribe(onNext: { ticker in
                print(ticker)
                let tickers = self.tickers
                guard let firstTicker = self.tickers.first else {
                    let x = SCIGenericType(type: .double, .init(doubleData:  0.0))
                    let y = SCIGenericType(type: .double, .init(doubleData: ticker.lastPrice))
                    self.lineData.appendX(x, y: y)
                    self.tickers = [ticker]
                    return
                }
                
                let x = SCIGenericType(type: .double, .init(doubleData:  ticker.date.timeIntervalSince(firstTicker.date)))
                let y = SCIGenericType(type: .double, .init(doubleData: ticker.lastPrice))
                self.lineData.appendX(x, y: y)
                self.tickers = tickers + [ticker]
                
                let diff = self.tickers.count - self.visibleCapacity
                
                let location: Int
                let length: Int
                if diff <= 0 {
                    location = 0
                    length = self.tickers.count
                } else {
                    location = self.tickers.count - self.visibleCapacity
                    length = self.visibleCapacity
                }
                self.visiblePartVariable.accept(.init(location: location, length: length))
                
            }).disposed(by: disposeBag)
//        tickersVariable.subscribe(onNext: { [weak self] tickers in
//            guard let firstTicker = tickers.first else {
//                return
//            }
//            tickers.forEach {
//                let x = SCIGenericType(type: .double, .init(doubleData:  $0.date.timeIntervalSince(firstTicker.date)))
//                let y = SCIGenericType(type: .double, .init(doubleData: $0.lastPrice))
//                lineData.appendX(x, y: y)
//            }
//            let lineRenderableSeries = SCIFastLineRenderableSeries()
//            lineRenderableSeries.dataSeries = lineData
//            let marker = SCICrossPointMarker()
//            marker.width = 4.0
//            marker.height = 4.0
//            lineRenderableSeries.style.pointMarker = marker
//            self?.chartDataVariable.accept(lineRenderableSeries)
//        }).disposed(by: disposeBag)
    }
}
