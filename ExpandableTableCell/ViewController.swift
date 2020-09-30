//
//  ViewController.swift
//  ExpandableTableCell
//
//  Created by maochun on 2020/9/26.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .blue
        //tableView.estimatedRowHeight = 60
        //tableView.rowHeight = 100 //UITableView.automaticDimension
        //tableView.allowsSelection = true
        //tableView.frame = self.view.bounds
        
        //tableView.borderColor = UIColor.black
        //tableView.borderWidth = 5.0
        
        //tableView.isEditing = true
        
        tableView.showsVerticalScrollIndicator = false
    
        //tableView.estimatedRowHeight = 50
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        
        
        self.view.addSubview(tableView)

            NSLayoutConstraint.activate([
                
                tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
                tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            ])
        
        
        tableView.register(TestTableViewGroupCell.self, forCellReuseIdentifier: TestTableViewGroupCell.cellIdentifier())
        
        return tableView
    }()
    
    var groupItemNum = 10
    var groupItemExpandFlagArr = [Bool]()
    var groupCellHeightArr = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.theTableView.reloadData()
        
        for _ in 0 ..< groupItemNum{
            groupItemExpandFlagArr.append(false)
        }
        
        for _ in 0 ..< groupItemNum{
            groupCellHeightArr.append(60)
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewGroupCell.cellIdentifier(), for:indexPath)
     
        if let commonCell = cell as? TestTableViewGroupCell{
            
            var items = [String]()
            for i in 0 ..< indexPath.row + 1{
                items.append("Item \(i)")
            }
            
            commonCell.setup(name: "Test group  \(indexPath.row)", items: items, expanded: self.groupItemExpandFlagArr[indexPath.row])
            self.groupCellHeightArr[indexPath.row] = commonCell.getCellHeight()
            print("Row \(indexPath.row) height = \(self.groupCellHeightArr[indexPath.row])")
        }
        print("setup row \(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TestTableViewGroupCell{
            print("select row \(indexPath.row)")
            cell.toggleCellStatus()
            self.groupItemExpandFlagArr[indexPath.row] = !self.groupItemExpandFlagArr[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("Row \(indexPath.row) height=\(self.groupCellHeightArr[indexPath.row])")
        return self.groupCellHeightArr[indexPath.row]
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //let movedObject = self.self.sectionArray[sourceIndexPath.section].itemNameArr[sourceIndexPath.row]
        //self.sectionArray[sourceIndexPath.section].itemNameArr.remove(at: sourceIndexPath.row)
        //self.sectionArray[destinationIndexPath.section].itemNameArr.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

