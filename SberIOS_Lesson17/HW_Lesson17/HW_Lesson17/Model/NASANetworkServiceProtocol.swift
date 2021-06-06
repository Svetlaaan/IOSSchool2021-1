//
//  NASANetworkServiceProtocol.swift
//  SberIOS_Lesson17
//
//  Created by Svetlana Fomina on 06.06.2021.
//

import Foundation

typealias GetNASAAPIResponse = Result<[GetDayDataResponse], NetworkServiceError>

protocol NASANetworkServiceProtocol {
	func getDataFromAPI(with completion: @escaping (GetNASAAPIResponse) ->Void)
	func loadImage(imageUrl: String, completion: @escaping (Data?) -> Void)
}
