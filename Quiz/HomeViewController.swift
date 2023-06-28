//
//  HomeViewController.swift
//  Quiz
//
//  Created by Padmavathi Sivakumar on 2023-06-27.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startPlay()  {
        let  vc = storyboard?.instantiateViewController(identifier: "instructions") as! InstructionsViewController
        vc.modalPresentationStyle  = .fullScreen
        present(vc, animated: true)
    }
}
