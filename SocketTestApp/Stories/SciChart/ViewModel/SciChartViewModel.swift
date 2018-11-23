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
    let chartDataVariable = BehaviorRelay<SCIRenderableSeriesBase>(value: SCIFastLineRenderableSeries())
    private var tickersVariable = BehaviorRelay<[Ticker]>(value: [])
    
    init() {
        bind()
    }
    
    func bind() {
        provider.tickerSubject
            .subscribe(onNext: { [weak self] ticker in
                print(ticker)
                guard var tickers = self?.tickersVariable.value else {
                    return
                }
                tickers.append(ticker)
                self?.tickersVariable.accept(tickers)
            }).disposed(by: disposeBag)
        tickersVariable.subscribe(onNext: { [weak self] tickers in
            guard let firstTicker = tickers.first else {
                return
            }
            let lineData = SCIXyDataSeries(xType: .double, yType: .double)
            tickers.forEach {
                let x = SCIGenericType(type: .double, .init(doubleData:  $0.date.timeIntervalSince(firstTicker.date)))
                let y = SCIGenericType(type: .double, .init(doubleData: $0.lastPrice))
                lineData.appendX(x, y: y)
            }
            let lineRenderableSeries = SCIXyScatterRenderableSeries()
            lineRenderableSeries.dataSeries = lineData
            self?.chartDataVariable.accept(lineRenderableSeries)
        }).disposed(by: disposeBag)
    }    
}
