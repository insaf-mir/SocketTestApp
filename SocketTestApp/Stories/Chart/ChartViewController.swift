//
//  ChartController.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 18.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChartViewController: UIViewController {
    let viewModel = ChartViewModel()
    let disposeBag = DisposeBag()
    let contentView = ChartView(frame: UIScreen.main.bounds)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
 
    func bind() {
        viewModel.chartDataVariable.subscribe(onNext: { [weak self] data in
            self?.contentView.update(data)
        })
        .disposed(by: disposeBag)
    }
    
}
