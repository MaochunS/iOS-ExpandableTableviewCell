//
//  TestTableViewGroupCell.swift
//  ExpandableTableCell
//
//  Created by maochun on 2020/9/26.
//

import UIKit

class TestTableViewGroupCell: UITableViewCell {
    
    
    lazy var itemNameLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"

        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        //label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.init(name: "Helvetica", size: 18)
        label.textColor = .white //UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.left
        
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        


        self.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        return label
    }()
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        //tableView.estimatedRowHeight = 60
        //tableView.rowHeight = 100 //UITableView.automaticDimension
        //tableView.allowsSelection = true
        //tableView.frame = self.view.bounds
        
        //tableView.borderColor = UIColor.black
        //tableView.borderWidth = 5.0
        //tableView.alwaysBounceVertical = false
        //tableView.bounces = false
        tableView.isScrollEnabled = false
        
       
    
        //tableView.estimatedRowHeight = 50
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        

        //tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0);
        
        self.addSubview(tableView)

            NSLayoutConstraint.activate([
                
                tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
                tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            ])
        
        
        tableView.register(TestTableViewCell.self, forCellReuseIdentifier: TestTableViewCell.cellIdentifier())
        
        return tableView
    }()
    
    var expanded = false
    var itemArray: [String]?
    var rowHeight:CGFloat = 50
    
    func setup(name:String, items:[String]?, expanded:Bool){
        
        
        self.backgroundColor = .none //.gray //UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
      
        if let items = items{
            itemArray = items
            self.theTableView.isHidden = true
            
        }
        
        self.expanded = expanded
        if expanded{
            self.itemNameLabel.text = "-  " + name
            self.theTableView.isHidden = false
            self.theTableView.reloadData()
        }else{
            self.itemNameLabel.text = "+  " + name
        }
        
        
        print("cell expanded \(expanded)")
    }
    
    func getCellHeight()->CGFloat{
        if expanded, let items = self.itemArray{
        
            return rowHeight * CGFloat(items.count) + 60
        
        }
        
        return 60
    }
    
    func toggleCellStatus(){
        expanded = !expanded
        
        print("cell is \(expanded)")
    }
    
    @objc func rightSwipeHeader(_ gestureRecognizer: UISwipeGestureRecognizer){
        var frame = self.frame
        
        if frame.origin.x != 0{
            frame.origin.x = 0
            UIView.animate(withDuration: 0.2) {
                self.frame = frame
            }
        }
        
    }
    
    @objc func leftSwipeHeader(_ gestureRecognizer: UISwipeGestureRecognizer){
        var frame = self.frame
        
        if frame.origin.x == 0{
            frame.origin.x -= 100
            UIView.animate(withDuration: 0.2) {
                self.frame = frame
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeHeader(_:)))
        leftSwipe.direction = .left
        addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeHeader(_:)))
        rightSwipe.direction = .right
        addGestureRecognizer(rightSwipe)
    }
}


extension TestTableViewGroupCell: UITableViewDelegate, UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.cellIdentifier(), for:indexPath)
     
        if let commonCell = cell as? TestTableViewCell{
            commonCell.setup(name: "Test cell \(indexPath.section) \(indexPath.row)")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
