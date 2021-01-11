//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation
import UIKit

struct GroceryID: Equatable
{
    var id: Int64 = -1
    
    static var issuedID: Int64 = 0
    static func issue() -> GroceryID
    {
        GroceryID.issuedID += 1
        return GroceryID(id : GroceryID.issuedID)
    }
    
    static func setIssuedID(newVal: Int64)
    {
        GroceryID.issuedID = newVal
    }
}

struct DueDate
{
    static let secondOfDay: Double = 60*60*24.0
    
    var date: Date
    
    init(_ addingDay: Int)
    {
        date = Date().addingTimeInterval(DueDate.secondOfDay*Double(addingDay))
    }
}

struct TypedImage
{
   var filename: String
   var fileExtension: String

   func image() -> UIImage?
   {
      return UIImage(named: "\(filename).\(fileExtension)")
   }
}

class GroceryHistory
{
    var id: GroceryID
    var title: String
    var category: Category
    var favorite: Bool = false
    var lastestPurchaseDate: Date = Date()
    var image: TypedImage?
    
    init(title: String, category: Category)
    {
        id = GroceryID.issue()
        self.title = title
        self.category = category
    }
    
    enum Category: String, CaseIterable
    {
        case ETC = "ETC"
        case MeatsAndEggs = "MeatsAndEggs"
        case MarineProducts = "MarineProducts"
        case CookingAndSidedishes = "CookingAndSidedishes"
        case Vegetable = "Vegetable"
        case Fruits = "Fruits"
        case DrinksAndSnacks = "DrinksAndSnacks"
        case SeasonedAndOilAndSauce = "SeasonedAndOilAndSauce"
    }
}

struct Grocery
{
    //var id: GroceryID           //GroceryHistory id
    var info: GroceryHistory
    
    var count: Int
    var isPercentageCount: Bool
    
    var dueDate: DueDate
    
    var storage: Storage
    var fridgeName: String
    
    var notes: String?
    
    
    enum Storage: Int, CaseIterable 
    {
        case Refrigeration = 0
        case Freezing = 1
        case Outdoor = 2
        
        var description: String
        {
            switch self
            {
            case .Refrigeration:
                return "냉장"
            case .Freezing:
                return "냉동"
            case .Outdoor:
                return "실외"
            }
        }
    }
}

struct GeroceryCart
{
    var id: Int64
    var isPurchased: Bool
}


func getGroceryHistory(title: String, category: GroceryHistory.Category) -> GroceryHistory
{
    if let groceryHistory = groceryHistories.first(where: {$0.title == title && $0.category == category})
    {
        return groceryHistory
    }
    else
    {
        let groceryHistory = GroceryHistory(title: title, category: category)
        groceryHistories.append(groceryHistory)
        return groceryHistory
    }
}


// 메인뷰 냉장고 이름 선택
var fridgeNames = ["신선한냉장고", "김치냉장고", "추가냉장고1", "추가냉장고2"]
var selectedFridgeIndex: [Int] = [0] // 다중 선택가능, fridgeNames index를 배열로 저장한다.
var selectedfrideName = fridgeNames[selectedFridgeIndex[0]] // 다중선택된 selectedFridgeIndex중 첫번째 것으로 할당

// 메인뷰의 필터링
typealias FridgeViewFilter = Grocery.Storage

// 메인뷰의 소팅
enum FridgeViewSort: Int, CaseIterable
{
    case CategoryFilter = 0
    
    var description: String
    {
        switch self
        {
        case .CategoryFilter:
            return "분류별"
        }
    }
}

// adding dumy data
var groceryID: GroceryID = GroceryID()
//var groceryHistories: [GroceryHistory] = []
//var groceries: [Grocery] = []

var groceryHistories = [
    GroceryHistory(title: "양파", category: .Vegetable),
    GroceryHistory(title: "양배추", category: .Vegetable),
    GroceryHistory(title: "달걀", category: .MeatsAndEggs),
    GroceryHistory(title: "치즈", category: .MeatsAndEggs),
    GroceryHistory(title: "이유식용 소고기", category: .MeatsAndEggs),
    GroceryHistory(title: "사과", category: .Fruits),
    GroceryHistory(title: "고등어", category: .MarineProducts),
    GroceryHistory(title: "김치", category: .CookingAndSidedishes),
    GroceryHistory(title: "롯데햄)켄터키핫도그75g(냉동)", category: .MeatsAndEggs),
    GroceryHistory(title: "면사랑)해물볶음우동370g(냉동)", category: .CookingAndSidedishes)
]

var groceries = [
    Grocery(info: getGroceryHistory(title: "양파", category: .Vegetable), count: 5, isPercentageCount: false, dueDate: DueDate(30), storage: .Outdoor, fridgeName: selectedfrideName),
    Grocery(info: getGroceryHistory(title: "양배추", category: .Vegetable), count: 1, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName),
    Grocery(info: getGroceryHistory(title: "달걀", category: .MeatsAndEggs), count: 30, isPercentageCount: false, dueDate: DueDate(7), storage: .Refrigeration, fridgeName: selectedfrideName),
    Grocery(info: getGroceryHistory(title: "치즈", category: .CookingAndSidedishes), count: 14, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "아기 먹일 유기농 치즈"),
    Grocery(info: getGroceryHistory(title: "이유식용 소고기", category: .MeatsAndEggs), count: 100, isPercentageCount: true, dueDate: DueDate(30), storage: .Refrigeration, fridgeName: selectedfrideName),
    Grocery(info: getGroceryHistory(title: "사과", category: .Fruits), count: 5, isPercentageCount: false, dueDate: DueDate(8), storage: .Refrigeration, fridgeName: selectedfrideName),
    Grocery(info: getGroceryHistory(title: "고등어", category: .MarineProducts), count: 3, isPercentageCount: false, dueDate: DueDate(3), storage: .Freezing, fridgeName: selectedfrideName),
    Grocery(info: getGroceryHistory(title: "김치", category: .CookingAndSidedishes), count: 50, isPercentageCount: true, dueDate: DueDate(60), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "19년도 김장 김치"),
    Grocery(info: getGroceryHistory(title: "롯데햄)켄터키핫도그75g(냉동)", category: .CookingAndSidedishes), count: 10, isPercentageCount: false, dueDate: DueDate(90), storage: .Refrigeration, fridgeName: selectedfrideName),
    Grocery(info: getGroceryHistory(title: "면사랑)해물볶음우동370g(냉동)", category: .CookingAndSidedishes), count: 5, isPercentageCount: false, dueDate: DueDate(30), storage: .Refrigeration, fridgeName: selectedfrideName)
    ]




