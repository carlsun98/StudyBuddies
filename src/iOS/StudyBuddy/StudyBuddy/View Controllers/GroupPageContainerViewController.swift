//
//  GroupPageContainerViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 5/1/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class GroupPageContainerViewController: UIViewController {

    var child : GroupPageViewController? = nil

    @IBOutlet weak var coverUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(groupChanged), name: .currentGroupChanged, object: nil)
        // Do any additional setup after loading the view.
        groupChanged()
    }
    
    @objc func groupChanged() {
        if (Data.sharedInstance.currentGroup == nil) {
            coverUpView.isHidden = false
        } else {
            coverUpView.isHidden = true
        }
        child?.updateGroup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showChildViewController") {
            child = segue.destination as? GroupPageViewController
        }
    }
    
    

}
