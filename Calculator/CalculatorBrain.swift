//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by HsuKaiChieh on 04/02/2018.
//  Copyright © 2018 HKC. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    private var accumulator: Double?
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private enum Operationi {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    private var operations: Dictionary<String, Operationi> = [
        "π" : .constant(Double.pi),
        "e" : .constant(M_E),
        "cos" : .unaryOperation(cos),
        "±" : .unaryOperation{-$0},
        "x" : .binaryOperation(*),
        "÷" : .binaryOperation{$0 / $1},
        "+" : .binaryOperation(+),
        "-" : .binaryOperation{$0 - $1},
        "=" : .equals
    ]
    private var pendingBinaryOperation:PendingBinaryOperation?
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            case .unaryOperation(_):
                break
            }
        }
    }
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
}
