//
//  DateCell.swift
//  SberIOS_Lesson17
//
//  Created by Svetlana Fomina on 06.06.2021.
//

import UIKit

final class DateCell: UITableViewCell {

	static let identifier = "DateCell"

	func configure(with model: GetDayDataResponse) {
		textLabel?.text = model.title
	}
}
