//
//  JsonFileManager.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//


import Foundation

class LocalPersistenceService {

    // Encode an object to Data and save it to a file, and replace existing content
    func saveObject<T: Encodable>(_ object: T, toFile fileName: String) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(object)

                    guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                        return
                    }

            let fileURL = documentsDirectory.appendingPathComponent(fileName)

            // Save the updated data to the file
            try data.write(to: fileURL)
            print("Object saved successfully at: \(fileURL)")
        } catch {
            print("Error saving object to file: \(error)")
        }
    }
}


//do {
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//    let jsonData = try encoder.encode(weatherData)
//
//    LocalJsonFileManager.saveToJsonFile(data: jsonData, fileName: "weatherData.json")
//} catch {
//    print("Error encoding data: \(error)")
//}
