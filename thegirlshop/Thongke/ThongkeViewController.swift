//
//  ThongkeViewController.swift
//  thegirlshop
//
//  Created by Thinh Nguyen on 5/12/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

private struct Config {
    static let rowHeightTable = 70 * Ratio.horizontal
}

final class ThongkeViewController: UIViewController {

    @IBOutlet fileprivate weak var soLuongLabel: UILabel!
    @IBOutlet fileprivate weak var thanhtienLabel: UILabel!
    @IBOutlet fileprivate weak var inButton: UIButton!
    @IBOutlet fileprivate weak var doneButton: UIButton!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    var homeVC = HomeViewController()
    
    fileprivate var viewModel = ThongkeViewModel() {
        didSet {
            //updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configUI()
        configTableView()
    }
    
    private func configUI() {
       // soLuongLabel.text = homeVC.soluongBan
        //thanhtienLabel.text = homeVC.tongtien
    }
    
    private func configTableView() {
        
        tableView.register(ThongKeTableCell.self, forCellReuseIdentifier: "ThongKeTableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Config.rowHeightTable
    }
    
    @IBAction private func dismissVC(sender: UIButton){
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func inTouchUpInSide(sender: UIButton){
        printData()
    }
    
    private func printData(){
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfoOutputType.grayscale
        printInfo.orientation = .landscape
        printInfo.jobName = "My Print Sumi"
        // Set up print controller
        let printController = UIPrintInteractionController.shared
        printController.delegate = self
        printController.printInfo = printInfo
        UIView.animate(withDuration: 0.5) {
            self.inButton.isHidden = true
            self.doneButton.isHidden = true
            self.view.alpha = 0.5
        }
        // Assign a UIImage version of my UIView as a printing iten
        printController.printingItem = view.toImage()
        // Do it
        printController.present(from: view.bounds, in: view, animated: true, completionHandler: nil)
    }
}

//Mark: - UIPrintInteractionControllerDelegate
extension ThongkeViewController: UIPrintInteractionControllerDelegate {
    public func printInteractionControllerWillDismissPrinterOptions(_ printInteractionController: UIPrintInteractionController) {
        UIView.animate(withDuration: 0.5) {
            self.inButton.isHidden = false
            self.doneButton.isHidden = false
            self.view.alpha = 1
        }
    }
}

// MARK: - UITableViewDelegate
extension ThongkeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ThongkeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return  20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThongKeTableCell", for: indexPath)
        return cell
        
    }
}
