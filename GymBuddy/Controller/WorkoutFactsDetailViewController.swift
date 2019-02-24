//
//  WorkoutFactsDetailViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-02-10.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit

class WorkoutFactsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    
    
    @IBOutlet var workoutImageView : UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: WorkoutFactsDetailHeader!

    var workoutImageName = ""
    var workoutDescription = ""
    var workoutIconImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white
        
        
        headerView.headerImageView.image = UIImage(named: workoutImageName)
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WOFactDetailIconTextCell.self), for: indexPath) as! WOFactDetailIconTextCell
            cell.shortTextLabel.text = workoutImageName
            cell.smallIconImageView.image = UIImage(named: workoutIconImageName)
            cell.selectionStyle = .none
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WOFactDetailIconTextCell.self), for: indexPath) as! WOFactDetailIconTextCell
            cell.shortTextLabel.text = ""
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkoutFactsDetailTextCell.self), for: indexPath) as! WorkoutFactsDetailTextCell
            cell.workoutFactsLabel.text = workoutDescription
            cell.selectionStyle = .none
            
            return cell
            
            
        default:
            fatalError("Failed")
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
