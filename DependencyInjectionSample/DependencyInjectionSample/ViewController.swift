//
//  ViewController.swift
//  DependencyInjectionSample
//
//  Created by Karthik on 08/09/21.
//

import UIKit
import MyAppUIkit
extension APICaller: DataFetchable {
    
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let coursesVC = CoursesViewController(dataFetchable: APICaller.shared as DataFetchable)
        self.present(coursesVC, animated: true)
    }
    
}

