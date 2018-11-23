//
//  SciChartController.swift
//  SocketTestApp
//
//  Created by Insaf Mukhametshin on 23/11/2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SciChart

class SciChartController: UIViewController {
    let viewModel = SciChartViewModel()
    let disposeBag = DisposeBag()
    let contentView = SciChartView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sci chart"
        prepareRenderableSerias()
        bind()
    }
    
    func bind() {
        viewModel.visiblePartVariable.subscribe(onNext: { range in
            self.contentView.updateVisiblePart(range)
        }).disposed(by: disposeBag)
    }
    
    func prepareRenderableSerias() {
        let lineRenderableSeries = SCIFastLineRenderableSeries()
        lineRenderableSeries.dataSeries = viewModel.lineData
        let marker = SCICrossPointMarker()
        marker.width = 4.0
        marker.height = 4.0
        lineRenderableSeries.style.pointMarker = marker
        contentView.chartView.renderableSeries.add(lineRenderableSeries)
    }
    
}
