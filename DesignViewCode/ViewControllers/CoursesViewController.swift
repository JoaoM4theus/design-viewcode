//
//  CoursesViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 02/12/23.
//

import UIKit

class CoursesViewController: UIViewController {

    var course: Course?
    
    init(course: Course? = nil) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
