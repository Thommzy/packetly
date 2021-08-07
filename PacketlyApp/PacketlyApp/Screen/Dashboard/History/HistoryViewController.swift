//
//  HistoryViewController.swift
//  PacketlyApp
//
//  Created by Tim on 06/08/2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let utilViewModel = UtilViewModel(dataService: DataService())
    private let disposedBag = DisposeBag()
    var historyArray: [OrderJobResponseModel?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupLoaderParentView()
        setupHistoryTableView()
    }
    
    func setupLoaderParentView() {
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBookOrderListResponse()
    }
    
    func setupHistoryTableView() {
        historyTableView.register(UINib(nibName: HistoryTableViewCell().identifier, bundle: nil), forCellReuseIdentifier: HistoryTableViewCell().identifier)
        historyTableView.rowHeight = UITableView.automaticDimension
    }
    
    func setup() {
        title = "History"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue ]
    }
}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: HistoryTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell().identifier, for: indexPath) as? HistoryTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(HistoryTableViewCell().identifier, owner: self, options: nil)?.first as? HistoryTableViewCell
        }
        cell?.order = historyArray[indexPath.row]
        cell?.selectionStyle = .none
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let orderDeatilVc = storyBoard.instantiateViewController(identifier: "OrderDetailViewController") as! OrderDetailViewController
        orderDeatilVc.orderDetails = historyArray[indexPath.row]
        self.navigationController?.pushViewController(orderDeatilVc, animated: true)
        print(indexPath.row)
    }
}

extension HistoryViewController {
    func setupBookOrderListResponse() {
        utilViewModel.orderListResult.asObservable()
            .subscribe(onNext: { [ weak self ]
                result in
                if let result = result {
                    self?.loadingIndicator.stopAnimating()
                    self?.historyArray = result.jobs.reversed()
                    self?.historyTableView.reloadData()
                    print(result)
                }
            })
            .disposed(by: disposedBag)
        utilViewModel.error.asObservable()
            .subscribe(onNext: { [weak self]
                error in
                if error != nil {
                    self?.toast(to: error?.localizedDescription ?? String())
                }
            })
            .disposed(by: disposedBag)
        let userId = Defaults[\.savedUserId]
        let data = OrderListRequest(user: userId)
        utilViewModel.doOrderList(with: data)
    }
}
