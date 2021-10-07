//
//  Meals.swift
//  FoodExpert
//
//  Created by admin on 09.09.2021.
//

import Foundation

enum Meals: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    
    init(index: Int) {
        switch index {
        case 0: self = .breakfast
        case 1: self = .lunch
        case 2: self = .dinner
        case 3: self = .snack
        default: self = .breakfast
        }
    }
}

