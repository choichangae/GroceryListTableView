//
//  GroceryListTableViewController.swift
//  GroceryListTableView
//
//  Created by changae choi on 2020/12/26.
//

import UIKit

class GroceryListTableViewController: UITableViewController {

    static var today = Date()
    
    var groceries: [Grocery] = [
        Grocery(title: "양파", category: .Vegetable, count: 5, dueDate: today.addingTimeInterval(secondOfDay*7*2), saveDate: today,
                notes: "", storage: .Outdoor, fridgeName: "메인 냉장고", isPercentageCount: false),
        Grocery(title: "양배추", category: .Vegetable, count: 1, dueDate: today.addingTimeInterval(secondOfDay*30), saveDate: today,
                notes: "", storage: .Refrigeration, fridgeName: "메인 냉장고", isPercentageCount: false),
        Grocery(title: "달걀", category: .MeatsAndEggs, count: 30, dueDate: today.addingTimeInterval(secondOfDay*7), saveDate: today,
                notes: "", storage: .Refrigeration, fridgeName: "메인 냉장고", isPercentageCount: false),
        Grocery(title: "치즈", category: .MeatsAndEggs, count: 14, dueDate: today.addingTimeInterval(secondOfDay*14), saveDate: today,
                notes: "아기 먹일 유기농 치즈", storage: .Refrigeration, fridgeName: "메인 냉장고", isPercentageCount: false),
        Grocery(title: "이유식용 소고기", category: .MeatsAndEggs, count: 100, dueDate: today.addingTimeInterval(secondOfDay*30), saveDate: today,
                notes: "", storage: .Refrigeration, fridgeName: "메인 냉장고", isPercentageCount: true),
        Grocery(title: "사과", category: .Fruits, count: 5, dueDate: today.addingTimeInterval(secondOfDay*8), saveDate: today,
                notes: "", storage: .Refrigeration, fridgeName: "메인 냉장고", isPercentageCount: false),
        Grocery(title: "고등어", category: .MarineProducts, count: 3, dueDate: today.addingTimeInterval(-secondOfDay*3), saveDate: today,
                notes: "", storage: .Refrigeration, fridgeName: "메인 냉장고", isPercentageCount: false),
        Grocery(title: "김치", category: .CookingAndSidedishes, count: 50, dueDate: today.addingTimeInterval(secondOfDay*60), saveDate: today,
                notes: "19년 김장 김치", storage: .Refrigeration, fridgeName: "메인 냉장고", isPercentageCount: true),
        Grocery(title: "롯데햄)켄터키핫도그75g(냉동)", category: .CookingAndSidedishes, count: 10, dueDate: today.addingTimeInterval(secondOfDay*90), saveDate: today,
                notes: "", storage: .Freezing, fridgeName: "메인 냉장고", isPercentageCount: false),
        Grocery(title: "면사랑)해물볶음우동370g(냉동)       ", category: .CookingAndSidedishes, count: 30, dueDate: today.addingTimeInterval(secondOfDay*7), saveDate: today,
                notes: "", storage: .Freezing, fridgeName: "메인 냉장고", isPercentageCount: false)
    ]
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var cellCount: [Int] = []
    var filteredGroceries: [[Grocery]] = []
    
    var filter: Grocery.FridgeFilter = .CategoryFilter
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        updateTableView()
    }
    
    func updateTableView()
    {
        numberOfSections = 0
        cellCount.removeAll()
        filteredGroceries.removeAll()
        sectionNames.removeAll()
        if filter == .CategoryFilter
        {
            for type in Grocery.Category.allCases
            {
                let filtered = groceries.filter{$0.category == type}
                if filtered.count > 0
                {
                    cellCount.append(filtered.count)
                    numberOfSections+=1
                    filteredGroceries.append(filtered)
                    sectionNames.append(type.rawValue)
                }
            }
        }
        else
        {
            let storageFilter: Grocery.Storage
            switch filter {
            case .RefrigerationFilter:
                storageFilter = .Refrigeration
            case .FreezingFilter:
                storageFilter = .Freezing
            case .OutdoorFilter:
                storageFilter = .Outdoor
            default:
                storageFilter = .Refrigeration
            }
            let filtered = groceries.filter{$0.storage == storageFilter}
            if filtered.count > 0
            {
                cellCount.append(filtered.count)
                numberOfSections=1
                filteredGroceries.append(filtered)
                sectionNames.append(Grocery.FridgeFilter.RefrigerationFilter.rawValue)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellCount[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionNames[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath) as! GroceryListTableViewCell

        // Configure the cell...
        if(filteredGroceries.count > 0)
        {
            let groceries = filteredGroceries[indexPath.section]
            let grocery = groceries[indexPath.row]
            
            cell.titleLabel?.text = grocery.title
            
            let diffDate = grocery.dueDate.timeIntervalSinceNow
            let diffDay = Int(diffDate/(secondOfDay))
            cell.expirationLabel?.text = diffDay>=0 ? String("D-\(diffDay+1)") : String("D+\(-diffDay)")
            cell.expirationLabel?.textColor = diffDay>=0 ? UIColor.darkGray : .red
            
            if(grocery.isPercentageCount)
            {
                cell.countButton.setTitle("\(grocery.count)%", for: .normal)
            }
            else
            {
                cell.countButton.setTitle("\(grocery.count)", for: .normal)
            }
            
        }
        
        return cell
    }
    @IBAction func filterSegmentControlChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0: filter = .CategoryFilter
        case 1: filter = .RefrigerationFilter
        case 2: filter = .FreezingFilter
        case 3: filter = .OutdoorFilter
        default: return
            
        }
        
        updateTableView()
        tableView.reloadData()

        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    @IBAction func unwindToGroceryListTableView(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        guard unwindSegue.identifier == "SaveUnwind" else { return }
        
        // 구현 필요..
        
        
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditCell"
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let groceries = filteredGroceries[indexPath.section]
            let grocery = groceries[indexPath.row]
            let navigationController = segue.destination as! UINavigationController
            let addGroceryTableViewController = navigationController.topViewController as! AddGroceryTableViewController
            
            addGroceryTableViewController.grocery = grocery
        }
    }
    

}
