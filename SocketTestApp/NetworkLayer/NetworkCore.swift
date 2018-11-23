//
//  NetworkCore.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 18.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import Foundation
import Starscream
import RxSwift

let SocketUrlString = "wss://api.bitfinex.com/ws"

class NetworkCore {
    var socket: WebSocket?
    let dataResponseSubject = PublishSubject<Data>()
    let stringResponseSubject = PublishSubject<String>()
    
    func post(data: String) {
        socket?.write(string: data)
    }
    
    func connect() -> Observable<Bool> {
        guard let url = URL(string: SocketUrlString) else {
            return Observable.just(false)
        }
        socket = WebSocket(url: url)
        
        let observable = Observable<Bool>.create { [weak self] observer -> Disposable in
            self?.socket?.onConnect = {
                observer.onNext(true)
            }
            
            self?.socket?.onDisconnect = { (error: Error?) in
                if let error = error {
                    print("socket disconnected with error: \(error)")
                }
                observer.onNext(false)
                guard let error = error else {
                    return
                }
                observer.onError(error)
            }
            
            self?.socket?.connect()
            self?.socket?.delegate = self
            
            return Disposables.create { [weak self] in
                self?.socket?.onConnect = nil
                self?.socket?.onDisconnect = nil
            }
        }
        return observable
    }
}

extension NetworkCore: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {

    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        stringResponseSubject.onNext(text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        dataResponseSubject.onNext(data)
    }
    
    
}
