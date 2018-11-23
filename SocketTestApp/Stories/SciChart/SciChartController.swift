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
        bind()
    }
    
    func bind() {
        viewModel.chartDataVariable.subscribe(onNext: { [weak self] data in
            self?.contentView.chartView.renderableSeries.clear()
            self?.contentView.chartView.renderableSeries.add(data)
        }).disposed(by: disposeBag)
    }
    
}
