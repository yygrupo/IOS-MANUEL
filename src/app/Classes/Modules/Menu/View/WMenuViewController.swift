//
//  WMenuViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit

class WMenuViewController: UIViewController, WMenuViewInterface, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView?
    
    var itemNames: [String] = []
    var itemImages: [String] = []
    
    var eventHandler: WMenuModuleInterface?

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
        
        tableView?.rowHeight = CGRectGetHeight((tableView?.frame)!) / itemNames.count.toCGFloat
        tableView?.reloadData()
    }
    
    // MARK: - Private
    func setupView() {
        itemNames = ["Tapas".localized, "Locáis".localized, "Puntuar".localized, "Puntuados".localized, "Quero probar".localized, "Mapa".localized, "Buscar".localized, "Acceder".localized, "Novas".localized, "Sobre PonteDeTapas".localized, "Termos en Condicións".localized]
        itemImages = ["tapas", "Shop", "Thumb Up", "Checked Checkbox 2", "Like", "Marker", "Search", "User", "News"]
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    // MARK: - UITableView delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WMenuTableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("menuCellReuseIdentifier", forIndexPath: indexPath) as! WMenuTableViewCell
        
        if indexPath.row < itemImages.count {
            let image = UIImage(named: itemImages[indexPath.row])
            cell.menuImageView?.image = image?.imageWithRenderingMode(.AlwaysTemplate)
            cell.menuImageView?.tintColor = UIColor(hexString: "#797979")
        } else {
            cell.menuImageView?.hidden = true
        }
        
        cell.menuTitle?.text = itemNames[indexPath.row]
        
        if indexPath.row == 1 || indexPath.row == 7 {
            cell.menuSeparator?.hidden = false
        } else {
            cell.menuSeparator?.hidden = true
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        eventHandler?.presentViewControllerAtIndex(indexPath.row)
    }

    // MARK: - WMenuViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here

}
