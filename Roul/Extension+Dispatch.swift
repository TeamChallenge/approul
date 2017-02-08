//
//  Extension+Dispatch.swift
//  Roul
//
//  Created by Thiago Vinhote on 07/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import Foundation

public func delay(_ time: Int, finish: @escaping () -> Void) {
    let delay = DispatchTime.now() + .seconds(time)
    DispatchQueue.main.asyncAfter(deadline: delay, execute: finish)
}
