//
//  CoursesViewController.swift
//  DependencyInjectionSample
//
//  Created by Karthik on 08/09/21.
//

import UIKit

public protocol DataFetchable {
    func fetchCourses(completion: @escaping ([String])->Void)
}

struct Courses {
    var name:String
}
public class CoursesViewController: UIViewController {
    var courseArr:[Courses] = []
    let dataFetchable: DataFetchable
    private let tableView:UITableView  = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        dataFetchable.fetchCourses { [weak self] strArr in
            _ = strArr.map({
                self?.courseArr.append(Courses(name: $0))
            })
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    
    
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
    }
}
extension CoursesViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseArr.count 
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  self.courseArr[indexPath.row].name
        return cell
        
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
