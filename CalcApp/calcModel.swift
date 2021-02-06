//
//  calcModel.swift
//  CalcApp
//
//  Created by Tagay Shyngys on 2/4/21.
//

import Foundation

enum Operation {
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double,Double)->Double)
    case equals
}




struct  CalculatorModel{
    var my_operation: Dictionary<String, Operation> =
        [
            "+" : Operation.binaryOperation({$0+$1}),
            "-" : Operation.binaryOperation({$0-$1}),
            "/" : Operation.binaryOperation({$0/$1}),
            "*" : Operation.binaryOperation({$0*$1}),
            "%" : Operation.binaryOperation({Double(Int($0)%Int($1))}),
            "+/-" : Operation.binaryOperation({$0-$1}),
            "AC" : Operation.constant(0),
            "=" : Operation.equals

        ]
    
    private var global_value: Double?
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    
    var saving: SaveFirstOperandAndOperatoin?
    
    mutating func performOperation(_ operation: String){
        
        let symbol = my_operation[operation]!
        switch symbol {
        case .constant(let value):
            global_value = value
            
        case .unaryOperation(let function):
            global_value = function(global_value!)
            
        case .binaryOperation(let function):
            
            saving = SaveFirstOperandAndOperatoin(firstOperand: global_value!, operation: function)
            print(saving?.operation)
            print(saving?.firstOperand)
            
            
            
        case .equals:
            print(global_value)
            global_value = saving?.performOperationWith(secondOperand: global_value!)
            
            print(saving?.firstOperand)
            print(global_value)
        
            
        }
        
    }
    
        var result: Double?{
            get{
                return global_value
            }
        }
    
  
    struct SaveFirstOperandAndOperatoin {
        var firstOperand: Double
        var operation: (Double,Double) -> Double
        
        func performOperationWith(secondOperand op2: Double) -> Double{
            return operation(firstOperand,op2)
        }
        
    }
}
