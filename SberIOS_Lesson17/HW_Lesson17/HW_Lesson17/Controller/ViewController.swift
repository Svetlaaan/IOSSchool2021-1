//
//  ViewController.swift
//  SberIOS_Lesson17
//
//  Created by Svetlana Fomina on 05.06.2021.
//

import UIKit

class ViewController: BaseViewController {

	private let networkService: NASANetworkServiceProtocol
	private var dataSource = [GetDayDataResponse]()

	init(networkService: NASANetworkServiceProtocol) {
		self.networkService = networkService
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(DateCell.self, forCellReuseIdentifier: DateCell.identifier)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.showsVerticalScrollIndicator = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "NASA Pic Of Random Day"
		setAutoLayout()
		loadData()
	}

	deinit {
		print("ViewController deinit")
	}

	private func setAutoLayout() {
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	private func loadData() {
		isLoading = true
		self.networkService.getDataFromAPI(with: {self.process($0)})
	}

	private func process(_ response: GetNASAAPIResponse) {
		DispatchQueue.main.async {
			switch response {
			case .success(let data):
				self.dataSource.append(contentsOf: data)
				self.tableView.reloadData()
			case .failure(let error):
				self.showAlert(for: error)
			}
			self.isLoading = false
		}
	}

	private func showAlert(for error: NetworkServiceError) {
		let alert = UIAlertController(title: "ОШИБКА",
									  message: message(for: error),
									  preferredStyle: .alert)
		present(alert, animated: true)
	}

	private func message(for error: NetworkServiceError) -> String {
		switch error {
		case .network:
			return "Упал запрос"
		case .decodable:
			return "Не смогли распарсить"
		case .unknown:
			return "Непонятная ошибка"
		}
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		dataSource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.identifier, for: indexPath)
		(cell as? DateCell)?.configure(with: dataSource[indexPath.row])
		return cell
	}
}

extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row == dataSource.count - 1, !isLoading {
			isLoading = true
			networkService.getDataFromAPI(with: { self.process($0) })
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath,animated : true)
		let imageViewController = ImageViewController(networkService: networkService, imageUrl: dataSource[indexPath.row].url, date: dataSource[indexPath.row].date, explanation: dataSource[indexPath.row].explanation)
		navigationController?.pushViewController(imageViewController, animated: true)
	}
}
