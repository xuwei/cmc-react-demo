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
    var confirmTableViewCell: ConfirmTableViewCell?
    var viewModel = BuyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // needed when textfield is active and keyboard may cover up some ui
        setupKeyboardHandling()
        
        setupSubviews()
        
        // default method to setup screen ui
        setupUI()
        
        // respond to notifications if needed
        addObservables()
        CmcServiceManager.shared.blockchainTicker()
        self.viewModel.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func addObservables() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: NSNotification.Name(NotificationEvent.priceUpdate.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(confirm(_:)), name: NSNotification.Name(NotificationUIEvents.confirm.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancel(_:)), name: NSNotification.Name(NotificationUIEvents.cancel.rawValue), object: nil)
    }
    
    func setupSubviews() {
        self.confirmViewContainer.backgroundColor = .clear
        let confirmTableViewCell = UIView.loadFromNibNamed(nibNamed: "ConfirmTableViewCell") ?? UITableViewCell()
        confirmTableViewCell.translatesAutoresizingMaskIntoConstraints = false
        self.confirmViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.confirmViewContainer.addSubview(confirmTableViewCell)
        AutoLayoutUtil.shared.pinToSuperview(view, padding: 0.0)
        self.confirmTableViewCell = confirmTableViewCell as? ConfirmTableViewCell
    }
    
    func setupUI() {
        self.tableview.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        self.navigationController?.navigationBar.barStyle = .default
        self.view.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        self.tapToDismissKeyboard()
        self.tableview.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        // set estimatedRowHeight to value other than 0 to enable autolayout calculation of cell height
        self.tableview.estimatedRowHeight = 1
        self.tableview.separatorStyle = .none
        self.title = "\(AppData.shared.tradeType.rawValue) Order"
        // register the reusable cells which we need to compose our screen
        self.registerReusableCells()
        
        
        
    }
}

//MARK: handling textfield delegate
extension BuyViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let cTextField = textField as! CTextField
        if cTextField.tag == AmountEntryTextFieldTag.amount.rawValue {
            let amounts = Double(cTextField.text ?? "0.0") ?? 0.0
            LoggingUtil.shared.cPrint("amount textFieldDidEndEditing")
            self.viewModel.amountEntry.calculatedUnitsByAmount(amounts)
        } else if cTextField.tag == AmountEntryTextFieldTag.unit.rawValue {
            LoggingUtil.shared.cPrint("unit textFieldDidEndEditing")
            let units = Double(cTextField.text ?? "0.0") ?? 0.0
            self.viewModel.amountEntry.calculateAmountByUnits(units)
        }
        
        self.tableview.reloadData()
    }
    
    func validateIsNumeric(_ cTextField: CTextField)->Bool {
        guard StringUtil.shared.isNumericOnly(cTextField.text ?? "") else {
            NotificationService.shared.notify(NotificationUIEvents.disableConfirmView.rawValue, key: "", object: nil)
            return false
        }
        return true
    }
}

//MARK: handling notifications
extension BuyViewController {
    
    @objc func confirm(_ notification: NSNotification) {
        LoggingUtil.shared.cPrint("confirm")
        showMessage("Confirm Buy?", completion: nil)
    }
    
    @objc func cancel(_ notification: NSNotification) {
        LoggingUtil.shared.cPrint("cancel")
        showMessage("Cancelled", completion: nil)
    }
    
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
        if cell is AmountEntryTableViewCell {
            LoggingUtil.shared.cPrint("assign textfield delegate here...")
            let amountEntry = cell as! AmountEntryTableViewCell
            amountEntry.unitTextField.delegate = self
            amountEntry.amountTextField.delegate = self
        }
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

//MARK: random theme
extension BuyViewController {
    @IBAction func randomTheme() {
        LoggingUtil.shared.cPrint("switch theme")
        AppConfig.shared.updateTheme()
        setupUI()
        if self.confirmTableViewCell != nil {
            self.confirmTableViewCell?.setupUI()
        }
        self.view.setNeedsLayout()
        self.tableview.reloadData()
    }
}
