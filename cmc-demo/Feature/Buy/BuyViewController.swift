//
//  ViewController.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 1/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import NotificationCenter
import PopOverMenu

class BuyViewController: UIViewController, CViewControllerProtocol  {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var confirmViewContainer: UIView!
    var confirmTableViewCell: ConfirmTableViewCell?
    var viewModel = TradeViewModel()
    var timer: Timer?
    var flashCount: Int = 0
    let numOfFlash = 6

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
        let confirmTableViewCell = UIView.loadFromNibNamed(nibNamed: "ConfirmTableViewCell") as! ConfirmTableViewCell
        guard let view = confirmTableViewCell.containerView else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.confirmViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.confirmViewContainer.addSubview(view)
        AutoLayoutUtil.shared.pinToSuperview(view, padding: 0.0)
        self.confirmTableViewCell = confirmTableViewCell
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cTextField = textField as! CTextField
        cTextField.setTextFieldState(.active)
    }
    
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
        
        cTextField.setTextFieldState(.normal)
        textField.resignFirstResponder()
        self.tableview.reloadData()
    }
    
    func validateIsNumeric(_ cTextField: CTextField)->Bool {
        guard StringUtil.shared.isPositiveNumericOnly(cTextField.text ?? "") else {
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
        self.refreshTradeHeader()
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
        
        if cell is TradeHeaderTableViewCell {
            LoggingUtil.shared.cPrint("trigger flashing animation here...")
            let tradeHeader = cell as! TradeHeaderTableViewCell
            flash([tradeHeader.sellPriceLabel, tradeHeader.buyPriceLabel])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell is TradeHeaderTableViewCell {
            // flash the labels
            let tradeHeader = cell as! TradeHeaderTableViewCell
            self.flash([tradeHeader.sellPriceLabel, tradeHeader.buyPriceLabel])
        }
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

//MARK: theme selection
extension BuyViewController {
    @IBAction func switchTheme(_ sender: UIBarButtonItem!) {
        LoggingUtil.shared.cPrint("switch theme")
        let titles = AppConfig.themes.map { $0.name.rawValue }
        let popOverViewController = PopOverViewController.instantiate()
        popOverViewController.set(titles: titles)
        popOverViewController.popoverPresentationController?.barButtonItem = sender
        let height = CGFloat(titles.count) * AppConfig.shared.activeTheme.defaultButtonHeight + CGFloat(AppConfig.shared.activeTheme.smallPadding)
        
        popOverViewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*0.5, height: height)
        popOverViewController.presentationController?.delegate = self
        popOverViewController.completionHandler = { selectRow in
            self.selectedTheme(selectRow)
        }
        present(popOverViewController, animated: true, completion: nil)
        
    }
    
    func selectedTheme(_ index: Int) {
        AppConfig.shared.updateTheme(index)
        self.refresh()
    }
}

// MARK: flashing effect on price labels
extension BuyViewController {
    func flash(_ labels: [CLabel]) {
  
        self.flashCount = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: AppConfig.shared.activeTheme.quickAnimationDuration, repeats: true) { (timer) in
            
            labels.forEach { label in
                label.textColor = (self.flashCount % 2 == 0) ? AppConfig.shared.activeTheme.textColor : AppConfig.shared.activeTheme.profitColor
            }
            
            self.flashCount = self.flashCount + 1
            
            if self.flashCount == self.numOfFlash {
                labels.forEach { label in
                    label.textColor = label.prevColor
                }
                timer.invalidate()
                self.flashCount = 0
            }
        }
    }
}

// MARK: refresh use by selecting theme
extension BuyViewController {
    
    func refreshTradeHeader() {
        self.tableview.reloadRows(at: [self.viewModel.tradeHeaderIndexPath()], with: .automatic)
    }
    
    func refreshTable() {
        self.tableview.reloadData()
    }
    
    func refresh() {
        AppConfig.shared.setupNavBarUI(self)
        self.view.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        self.tableview.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        self.setupUI()
        self.tableview.reloadData()
        self.view.setNeedsDisplay()
    }
}

// MARK: delegate implementation needed by PopOverMenu
extension BuyViewController: UIAdaptivePresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

