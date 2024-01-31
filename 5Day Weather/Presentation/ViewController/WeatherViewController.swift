//
//  ViewController.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//
import UIKit
import Combine

class WeatherViewController: UIViewController, StoryboardInstantiable, HomeCoordinating {    
    
    var coordinator: HomeCoordinator?
    var viewModel: WeatherViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    var tableView:UITableView!
    var headerView:StickyHeaderView!
    var headerHeightConstraint:NSLayoutConstraint!
    
    var stickyHeaderHeight: CGFloat = .grid(30)
    var isOffline  = false


    lazy var defaultDataStorage: DefaultDataStorage = {
        return DefaultDataStorage()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchWeather()
        reloadViewUponRetrievingResults()
        setUpHeader()
        setUpTableView()
        observeInternetReachability()
    }
    
    func reloadViewUponRetrievingResults() {
        viewModel?.$weatherResponse
            .compactMap { $0?.weatherList.first}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentWeather in
                self?.tableView.reloadData()
                self?.initiateHeaderContentView(with: currentWeather)
            }
            .store(in: &cancellables)
    }
    
    func initiateHeaderContentView(with weatherItem: WeatherInfo) {
        guard let contentView = WeatherBlockView.loadFromNib()?
            .withLargeTemperatureSize()
        else { return }
        contentView.updateViewWith(weatherItem: weatherItem, shouldUseRelativeDate: true)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/3),
            contentView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16)
        ])
    }
    
    func setUpHeader() {
        headerView = StickyHeaderView(frame: CGRect.zero , title: Constant.cityName)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: stickyHeaderHeight)
        headerHeightConstraint.isActive = true
        
        let constraints:[NSLayoutConstraint] = [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        let constraints:[NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        tableView.registerCellNib(ForecastTableViewCell.self)
        tableView.separatorStyle =  .none
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func animateHeader() {
        self.headerHeightConstraint.constant = stickyHeaderHeight
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
            headerView.incrementColorAlpha(offset: self.headerHeightConstraint.constant)
        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 50 {
            self.headerHeightConstraint.constant -= scrollView.contentOffset.y/100
            headerView.decrementColorAlpha(offset: scrollView.contentOffset.y)
            
            if self.headerHeightConstraint.constant < 50 {
                self.headerHeightConstraint.constant = 50
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > 150 {
            animateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > 150 {
            animateHeader()
        }
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .grid(15)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let response = viewModel?.weatherResponse,
           let selectedItem = viewModel?.overViewResponse?[indexPath.row] {
            coordinator?.showDetail(response, selectedWeatherInfo: selectedItem, in: navigationController)
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.overViewResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if let viewModel = viewModel, isOffline || viewModel.promtDataFetchingFromLocal {
            var message = WeatherMessages.noLocalData
            if let savedDate = defaultDataStorage.retrieveDate(forKey: UserStorageKeys.last_update) {
                message = String(format: WeatherMessages.lastUpdateTimeFormat, savedDate.relativeFormat())
            }
            
            let label = UILabel()
            label.font  =  UIFont.systemFont(ofSize: .grid(1.5))
            label.textAlignment = .center
            label.text =  message
            return label
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0
        }
        return isOffline || viewModel.promtDataFetchingFromLocal ? .grid(8) : 0
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(ForecastTableViewCell.self, for: indexPath)
    cell.selectionStyle = .none
    let weatherList  = viewModel?.overViewResponse
    guard let foreCastItem = weatherList?[indexPath.row]  else  {
        return UITableViewCell()
    }
    cell.updateView(with: foreCastItem)
    
    return cell
}
}

extension WeatherViewController {

    private func observeInternetReachability() {
        viewModel?.$isInternetReachable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isReachable in
                if !isReachable {
                    // No internet connection, handle accordingly
                    if let topViewController = UIApplication.topViewController(base: self) {
                        topViewController.showAlert(title: AlertConstants.offlineTitle, message: AlertConstants.offlineMessage)
                        self?.isOffline = true
                    } else {
                        self?.isOffline = false
                    }
                }
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
