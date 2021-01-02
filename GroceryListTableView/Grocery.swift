//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation



struct Grocery {
    
    var title: String
    var category: Category
    var count: Int
    var dueDate: Date
    var saveDate: Date
    var notes: String
    var storage: Storage
    var fridgeName: String
    var isPercentageCount: Bool
    
    enum Category: String, CaseIterable {
        case ETC = "ETC"
        case MeatsAndEggs = "MeatsAndEggs"
        case MarineProducts = "MarineProducts"
        case CookingAndSidedishes = "CookingAndSidedishes"
        case Vegetable = "Vegetable"
        case Fruits = "Fruits"
        case DrinksAndSnacks = "DrinksAndSnacks"
        case SeasonedAndOilAndSauce = "SeasonedAndOilAndSauce"
    }

    enum Storage: Int
    {
        case Refrigeration = 0
        case Freezing = 1
        case Outdoor = 2
        
        var description: String {
            switch self {
            case .Refrigeration:
                return "냉장"
            case .Freezing:
                return "냉동"
            case .Outdoor:
                return "실외" 
              }
        }
    }
    
    enum FridgeFilter: String
    {
        case CategoryFilter = "분류별"
        case RefrigerationFilter = "냉장"
        case FreezingFilter = "냉동"
        case OutdoorFilter = "실외"
    }
}

let secondOfDay: Double = 60*60*24.0
