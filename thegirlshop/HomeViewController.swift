//
//  HomeViewController.swift
//  thegirlshop
//
//  Created by Thinh Nguyen on 5/11/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    static var shared: HomeViewController?
    
    enum Thongkes: Int {
        case ngay = 0
        case tuan
        case thang
    }
    
    enum Action {
        case tabButtonSelected(Thongkes)
    }

    @IBOutlet private weak var ngayButton: UIButton!
    @IBOutlet private weak var tuanButton: UIButton!
    @IBOutlet private weak var thangButton: UIButton!
    @IBOutlet private weak var thongkeButton: UIButton!
    @IBOutlet private weak var maQuanAoField: UITextField!
    @IBOutlet private weak var soluongTextField: UITextField!
    @IBOutlet private weak var giaTextField: UITextField!
    @IBOutlet private weak var thanhtienLabel: UILabel!
    @IBOutlet private weak var thanhTienButton: UIButton!
    @IBOutlet private weak var ketQuaTheoNgayLabel: UILabel!
    
    var soluongBan = ""
    var tongtien = ""
    var tinh: Int = 0
    var ketQua: Int = 0
    
    private var isThanhTienButtonEnable: Bool = false {
        didSet {
            thanhTienButton.isEnabled = isThanhTienButtonEnable
            thanhTienButton.setTitleColor(isThanhTienButtonEnable ? .white : .gray, for: .normal)
            thanhTienButton.backgroundColor = isThanhTienButtonEnable ? .orange : .lightGray
            thanhtienLabel.text = "0đ"
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ABC Shop"
        navigationController?.navigationBar.barTintColor = .orange
        congigUI()
    }
    
    // MARK: - Private Functions
    private func congigUI() {
        let tab: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeboard))
        view.addGestureRecognizer(tab)
        thanhtienLabel.text = "0" + "đ"
        selected(item: Thongkes.ngay)
        thongkeButton.border(color: .orange, width: 1)
        thongkeButton.cornerRadius = thongkeButton.frame.height * Ratio.horizontal / 2
        isThanhTienButtonEnable = false
        thanhTienButton.border(color: .white, width: 1)
        thanhTienButton.cornerRadius = thanhTienButton.frame.height * Ratio.horizontal / 2
    }
    
    @objc private func dismissKeboard() {
        view.endEditing(true)
    }
    
    private func reset() {
        ngayButton.titleLabel?.font = UIFont(name:"AmericanTypewriter", size: 17.0)
        ngayButton.setTitleColor(.gray, for: .normal)
        tuanButton.titleLabel?.font = UIFont(name:"AmericanTypewriter", size: 17.0)
        tuanButton.setTitleColor(.gray, for: .normal)
        thangButton.titleLabel?.font = UIFont(name:"AmericanTypewriter", size: 17.0)
        thangButton.setTitleColor(.gray, for: .normal)
    }

    private func selected(item: Thongkes?) {
        guard let item = item else { return }
        reset()
        switch item {
        case .ngay:
            ngayButton.setTitleColor(.orange, for: .normal)
            ngayButton.cornerRadius = ngayButton.frame.height * Ratio.horizontal / 2
            ngayButton.titleLabel?.font = UIFont(name:"AmericanTypewriter-Bold", size: 17.0)
            ketQuaTheoNgayLabel.text = String(tinh.formattedWithSeparator()) + "đ"
        case .tuan:
            tuanButton.setTitleColor(.orange, for: .normal)
            tuanButton.cornerRadius = tuanButton.frame.height * Ratio.horizontal / 2
            tuanButton.titleLabel?.font = UIFont(name:"AmericanTypewriter-Bold", size: 17.0)
            ketQuaTheoNgayLabel.text = String(tinh.formattedWithSeparator()) + "đ"
        case .thang:
            thangButton.titleLabel?.font = UIFont(name:"AmericanTypewriter-Bold", size: 17.0)
            thangButton.setTitleColor(.orange, for: .normal)
            thangButton.cornerRadius = thangButton.frame.height * Ratio.horizontal / 2
            thangButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            ketQuaTheoNgayLabel.text = String(tinh.formattedWithSeparator()) + "đ"
        }
    }
    
    private func checkEmptyTextFiled() {
            guard let isEmptySoluong = soluongTextField?.string.trimmed().isEmpty,
                let isEmptyGia = giaTextField?.string.trimmed().isEmpty,
                let isEmptyMa = maQuanAoField?.string.trimmed().isEmpty
                else { return }
            isThanhTienButtonEnable = !isEmptySoluong && !isEmptyGia && !isEmptyMa
    }
    
    @IBAction private func sortTouchUpInSide(sender: UIButton) {
        selected(item: Thongkes(rawValue: sender.tag))
    }
    
    @IBAction private func thanhTienTouchUpInSide(sender: UIButton) {
        guard let soluong = soluongTextField.text else { return }
        guard !soluong.isEmpty else { return }
        guard let gia = giaTextField.text else { return }
        guard !gia.isEmpty else { return }
        guard let soluongInt = Int(soluong) else { return }
        guard let giaInt = Int(gia) else { return }
        tinh = soluongInt * giaInt
        thanhtienLabel.text = String(tinh.formattedWithSeparator()) + "đ"
        ketQua = tinh
        tongtien = thanhtienLabel.text!
        soluongBan = soluong
        ketQuaTheoNgayLabel.text = String(ketQua.formattedWithSeparator()) + "đ"
    }
    
    @IBAction private func presenVC(sender: UIButton) {
        let thongkeVC = ThongkeViewController()
        thongkeVC.homeVC = self
        navigationController?.present(thongkeVC, animated: true, completion: nil)
    }
    
    @IBAction private func textFieldDidChangeValue(sender: UITextField) {
        checkEmptyTextFiled()
    }
}

//Mark - Uis
extension Int {
    func formattedWithSeparator() -> String {
        AppDelegate.numberFormatter.groupingSeparator = "."
        AppDelegate.numberFormatter.numberStyle = .decimal
        guard let formatted = AppDelegate.numberFormatter.string(for: self) else { return "" }
        return formatted
    }
}

extension String {
    public func trimmed(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        return trimmedLeft(characterSet: set).trimmedRight(characterSet: set)
    }
    
    public func trimmedLeft(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted) {
            return String(self[range.lowerBound ..< endIndex])
        }
        return ""
    }
    
    public func trimmedRight(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted, options: NSString.CompareOptions.backwards) {
            return String(self[startIndex ..< range.upperBound])
        }
        return ""
    }
}
