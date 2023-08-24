//
//  Extensions.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 19.08.2023.
//

import Foundation
import UIKit

//Entry
extension Entry: UICollectionViewDataSource, UICollectionViewDelegate {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel.spaceItems.count
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
          cell.backgroundColor = UIColor(red: 20/255, green: 40/255, blue: 70/255, alpha: 1.0)
          cell.layer.cornerRadius = 10.0
          cell.layer.applyShadow()

          let spaceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height))
          spaceLabel.text = viewModel.spaceItem(at: indexPath.row).title
          spaceLabel.textAlignment = .center
          spaceLabel.textColor = .white
          cell.addSubview(spaceLabel)

          return cell
      }

      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          var selectedVC: UIViewController?

          switch indexPath.row {
          case 0:
              selectedVC = ByDayInformation()
          case 1:
              selectedVC = ByWeekInfList()
          case 2:
              selectedVC = MoreInfList()
          default:
              selectedVC = nil
          }

          if let selectedVC = selectedVC {
              navigationController?.pushViewController(selectedVC, animated: true)
          }
      }
  }

extension CALayer {
    func applyShadow() {
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 0, height: 2)
        shadowOpacity = 0.4
        shadowRadius = 6
    }
}

//FavList
extension FavList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.dateStringForRow(at: indexPath)
        cell.backgroundColor = viewModel.backgroundColorForRow(at: indexPath)
        cell.textLabel?.textColor = viewModel.textColorForRow(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteDate(at: indexPath)
            // tableView.deleteRows(at: [indexPath], with: .fade) // Bu satırı kaldırın
        }
    }
}

//ByWeekInfList
extension ByWeekInfList: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath)
        let article = viewModel.articles[indexPath.item]

        cell.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)

        let titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: cell.frame.width - 30, height: 100))
        titleLabel.text = article.title
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        cell.contentView.addSubview(titleLabel)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticle = viewModel.articles[indexPath.item]

        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ByWeekDetail") as! ByWeekDetail
        detailVC.article = selectedArticle

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MoreInfList
extension MoreInfList: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionIsExpanded[section] ? viewModel.titlesBySection[viewModel.sections[section]]?.count ?? 0 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        let currentSection = viewModel.sections[indexPath.section]
        cell.textLabel?.text = viewModel.titlesBySection[currentSection]?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        headerView.backgroundColor = UIColor(red: 30/255, green: 45/255, blue: 75/255, alpha: 1.0)
        
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: headerView.frame.size.width - 15, height: headerView.frame.size.height))
        titleLabel.text = sectionTitle(for: section)
        titleLabel.textColor = UIColor(red: 0/255, green: 173/255, blue: 239/255, alpha: 1.0)
        
        headerView.addSubview(titleLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.tag = section
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 10/255, green: 20/255, blue: 40/255, alpha: 1.0)
        cell.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = viewModel.sections[indexPath.section]
        if let selectedTitle = viewModel.titlesBySection[currentSection]?[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "MoreInfDetailVC") as? MoreInfDetail {
                detailVC.selectedTitle = selectedTitle
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    @objc func sectionHeaderTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let section = gestureRecognizer.view?.tag {
            viewModel.sectionIsExpanded[section].toggle()
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
    
    func sectionTitle(for section: Int) -> String {
        let apiUrl = viewModel.sections[section]
        let decodedTitle = apiUrl.removingPercentEncoding?.replacingOccurrences(of: "https://images-api.nasa.gov/search?q=", with: "")
        let capitalizedTitle = decodedTitle?.capitalized(with: Locale.current) ?? "Diğer"
        return capitalizedTitle
    }
}
