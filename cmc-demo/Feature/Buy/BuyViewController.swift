//
//  ViewController.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 1/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import NotificationCenter

class BuyViewController: UIViewController, CViewControllerProtocol  {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var confirmViewContainer: UIView! 
    var viewModel = BuyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // needed when textfield is active and keyboard may cover up some ui
        setupKeyboardHandling()
        
        // default method to setup screen ui
        setupUI()
        
        // respond to notifications if needed
        addObservables()
        
        self.viewModel.load()
    }
    
    func addObservables() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: NSNotification.Name(NotificationEvent.priceUpdate.rawValue), object: nil)
    }
    
    func setupUI() {
        self.tapToDismissKeyboard()
        self.tableview.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        // set estimatedRowHeight to value other than 0 to enable autolayout calculation of cell height
        self.tableview.estimatedRowHeight = 1
        self.tableview.separatorStyle = .none
        self.title = "\(AppData.shared.tradeType.rawValue) Order"
        // register the reusable cells which we need to compose our screen
        self.registerReusableCells()
        
        self.confirmViewContainer.backgroundColor = .clear
        let confirmTableViewCell = UIView.loadFromNibNamed(nibNamed: "ConfirmTableViewCell") ?? UITableViewCell()
        confirmTableViewCell.translatesAutoresizingMaskIntoConstraints = false
        self.confirmViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.confirmViewContainer.addSubview(confirmTableViewCell)
        AutoLayoutUtil.shared.pinToSuperview(view, padding: 0.0)
        
    }
}

//MARK: handling notifications
extension BuyViewController {
    @objc func updateUI(_ notification: NSNotification) {
        LoggingUtil.shared.cPrint("update UI")
        self.tableview.reloadData()
    }
}


//MARK: UITableViewDelegate and UITableViewDataSource
extension BuyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // setup cell
        let section: CTableSectionViewModel = self.viewModel.sections[indexPath.section]
        let cellViewModel: CTableViewCellViewModelProtocol = section.rows[indexPath.row]
        let cell: CTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath) as! CTableViewCell
        cell.viewModel = cellViewModel
        cell.setupUI()
        return cell
    }
    
    func registerReusableCells() {
        let cellModels: [CTableViewCellViewModelProtocol] =
            [SpacerTableViewCellViewModel(),
             TradeHeaderViewCellViewModel(),
        AmountEntryTableViewCellViewModel(),
            ConfirmTableViewCellViewModel()]
        
        for vm: CTableViewCellViewModelProtocol in cellModels {
            let nib = UINib(nibName: vm.identifier, bundle: nil)
            self.tableview.register(nib, forCellReuseIdentifier: vm.identifier)
        }
    }
}

//MARK: implement function which returns the scrollView for keyboard handling logics
extension BuyViewController {
    override func baseScrollView() -> UIScrollView? {
        return self.tableview
    }
}

