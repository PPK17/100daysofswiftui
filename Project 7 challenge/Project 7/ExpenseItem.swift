//
//  ExpenseItem.swift
//  Project 7
//
//  Created by Pedro Pablo on 22/08/22.
//

import Foundation

//Dice que nuestros struct tendran un ID siempre, y no se necesita el identificador en el ForEach
struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
