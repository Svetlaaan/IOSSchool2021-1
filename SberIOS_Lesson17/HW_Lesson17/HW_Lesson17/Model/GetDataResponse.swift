//
//  GetDataResponse.swift
//  SberIOS_Lesson17
//
//  Created by Svetlana Fomina on 06.06.2021.
//

import Foundation

struct GetDayDataResponse: Decodable {
	let date: String
	let explanation: String
	let title: String
	let url: String
}
