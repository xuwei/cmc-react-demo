//
//  ViewController.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 1/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, CViewControllerProtocol  {
    
    @IBOutlet weak var tableview: UITableView!
    var viewModel = BuyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add pull to refresh to uitableview
        self.tableview.addPullToRefreshAction {
            self.updateUI()
        }
        
        // needed when textfield is active and keyboard may cover up some ui
        setupKeyboardHandling()
        
        // default method to setup screen ui
        setupUI()
        
        // respond to notifications if needed
        addObservables()
    }
    
    func addObservables() {
    }
    
    func setupUI() {
    }
    
    func updateUI() {
        
    }
}

extension BuyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return UITableViewCell()
   }
}

extension BuyViewController {
    override func baseScrollView() -> UIScrollView? {
        return self.tableview
    }
}

