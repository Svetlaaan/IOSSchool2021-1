//
//  FilterService.swift
//  FiltersHW_19
//
//  Created by Svetlana Fomina on 19.06.2021.
//

import UIKit

class FilterService {

	public func doFilter(image: UIImage, filterName: String, intensity: CGFloat) -> UIImage {
		DispatchQueue.global().sync {
			let context = CIContext()

			if let filter = CIFilter(name: filterName) {
				let ciImage = CIImage(image: image)
				filter.setValue(ciImage, forKey: kCIInputImageKey)
				filter.setValue(intensity, forKey: kCIInputIntensityKey)
				if let filteredImage = filter.outputImage {
					if let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent) {
						let outputImage = UIImage(cgImage: cgImage)
						return outputImage
					}
				}
			}
			return image
		}
	}
}
