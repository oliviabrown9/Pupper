//
//  CalendarViewController.swift
//  Pupper
//
//  Created by Olivia on 2/19/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView = CVCalendarView(frame: CGRect(x: 0,y:  20, width: 300,height: 450))
        
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
  
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
       self.calendarView.commitCalendarViewUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
