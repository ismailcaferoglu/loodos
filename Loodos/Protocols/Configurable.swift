//
//  Configurable.swift
//  Icrypex
//
//  Created by iMac on 12.03.2020.
//  Copyright © 2020 DevTeam. All rights reserved.
//

import UIKit

protocol Configurable {
    
    associatedtype T
    func configureWithModel(model: T)
}
