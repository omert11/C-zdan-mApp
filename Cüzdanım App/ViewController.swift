//
//  ViewController.swift
//  Cüzdanım App
//
//  Created by MacUser on 25.09.2018.
//  Copyright © 2018 MacUser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title="dsad"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let navigationback=UIBarButtonItem()
        navigationback.title="Geri"
        navigationItem.backBarButtonItem=navigationback
        
    }
    @IBAction func eklebtn(_ sender: Any) {
        performSegue(withIdentifier: "ekleekrani", sender: nil)
    }
    
}

