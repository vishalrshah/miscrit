//
//  DetailViewController.swift
//  my first project
//
//  Created by vishal shah on 21/10/16.
//  Copyright © 2016 vishal shah. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var poke: Pokemon!

    @IBOutlet weak var lblname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblname.text = poke.name
    }

   
}
