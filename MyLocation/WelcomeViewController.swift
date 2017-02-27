//
//  WelcomeViewController.swift
//  MyLocation
//
//  Created by Alex Votry on 2/26/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func HyperLink(_ sender: UIButton) {
      if let url = URL(string: "https://data.seattle.gov/") {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    }

}
