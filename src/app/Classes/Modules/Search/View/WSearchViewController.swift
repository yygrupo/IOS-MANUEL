//
//  WSearchViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit
import MBProgressHUD
import ActionSheetPicker_3_0

class WSearchViewController: UIViewController, WSearchViewInterface
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var nameViewContainer: UIView?
    @IBOutlet weak var radioViewContainer: UIView?
    @IBOutlet weak var categoryViewContainer: UIView?
    @IBOutlet weak var optionsViewContainer:UIView?
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var sliderRadio: UISlider!
    @IBOutlet weak var textFieldCategory: UITextField!
    @IBOutlet weak var imageViewCeliacsCheck: UIImageView!
    @IBOutlet weak var imageViewVegetarianCheck: UIImageView!
    @IBOutlet weak var imageViewVeganCheck: UIImageView!
    @IBOutlet weak var labelRadio: UILabel!
    
    @IBOutlet weak var buttonSearch: UIButton?
    
    // ***
    var categories: [WCategory] = []
    var loadingView: MBProgressHUD?
    var searchCriteria = WSearchCriteria()
    
    var eventHandler: WSearchModuleInterface?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateView()
        })
    }
    
    // MARK: - Private
    private func setupView() {
        let titleLabel = UILabel(frame: (self.navigationController?.navigationBar.frame)!)
        titleLabel.textAlignment = .Left
        titleLabel.text = "Buscar".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WSearchViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        nameViewContainer?.setupViewForApp()
        radioViewContainer?.setupViewForApp()
        categoryViewContainer?.setupViewForApp()
        optionsViewContainer?.setupViewForApp()
        
        buttonSearch?.clipsToBounds = true
        buttonSearch?.layer.cornerRadius = 8.0
        
        searchCriteria.celiacs = false
        searchCriteria.vegan = false
        searchCriteria.vegetarian = false
    }
    
    // MARK: - Private
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }
    
    // MARK: - WSearchViewInterface methods
    
    // *** implement view_interface methods here
    
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func updateViewWithCategories(categories: [WCategory]) {
        self.categories = categories
        stopLoadingView()
        
        let maxY = CGRectGetMaxY(buttonSearch!.frame)
        viewContainer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), maxY + 32)
        let height = CGRectGetHeight(viewContainer.frame)
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), height)
    }
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func radioChange(sender: UISlider) {
        if sender.value == 0 {
            labelRadio.text = "Radio".localized + ":"
        } else {
            labelRadio.text = "Radio".localized + ": \(sender.value) km"
        }
        searchCriteria.radio = sender.value
    }
    
    @IBAction func searchAction(sender: UIButton) {
        searchCriteria.name = textFieldName.text
        self.eventHandler?.doSearchWithCriteria(self.searchCriteria)
    }
    
    @IBAction func celiacsAction(sender: UIButton) {
        searchCriteria.celiacs = !searchCriteria.celiacs!
        if searchCriteria.celiacs == true {
            imageViewCeliacsCheck.image = UIImage(named: "Checked Checkbox 2")
        } else {
            imageViewCeliacsCheck.image = UIImage(named: "Unchecked Checkbox")
        }
    }
    
    @IBAction func veganAction(sender: UIButton) {
        searchCriteria.vegan = !searchCriteria.vegan!
        if searchCriteria.vegan == true {
            imageViewVeganCheck.image = UIImage(named: "Checked Checkbox 2")
        } else {
            imageViewVeganCheck.image = UIImage(named: "Unchecked Checkbox")
        }
    }
    
    @IBAction func vegetarianAction(sender: UIButton) {
        searchCriteria.vegetarian = !searchCriteria.vegetarian!
        if searchCriteria.vegetarian == true {
            imageViewVegetarianCheck.image = UIImage(named: "Checked Checkbox 2")
        } else {
            imageViewVegetarianCheck.image = UIImage(named: "Unchecked Checkbox")
        }
    }
    
    @IBAction func showCategories(sender: UIButton) {
        var rows = [String]()
        var initialSelection = 0
        for index in 0..<categories.count {
            rows.append((categories[index].name?.localized)!)
            if searchCriteria.category != nil && searchCriteria.category?.id == categories[index].id {
                initialSelection = index
            }
        }
        
        ActionSheetStringPicker.showPickerWithTitle("Seleccione".localized, rows: rows, initialSelection: initialSelection, doneBlock: { (picker, index, value) in
                self.textFieldCategory.text = value as? String
                self.searchCriteria.category = self.categories[index]
            }, cancelBlock: { (picker) in
                self.textFieldCategory.text = ""
                self.searchCriteria.category = nil
            }, origin: sender)
    }
}
