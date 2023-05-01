import Foundation
//  Created by Alexander Matheson
//  Created on 2023-May-01
//  Version 1.0
//  Copyright (c) 2023 Alexander Matheson. All rights reserved.
//
//  This program uses recursion to find the minimum number of an array.

// Enum for error checking.
enum InputError: Error {
  case InvalidInput
}

// Input in separate function for error checking.
func convert(strUnconverted: String) throws -> Int {
  guard let numConverted = Int(strUnconverted.trimmingCharacters(in: CharacterSet.newlines)) else {
    throw InputError.InvalidInput
  }
  return numConverted
}

// This function finds the min num of a list.
func findLowest(listOfNum: [Int], index: Int) -> Int {
  // Base case: The end of the array is reached, return the last element.
  if index == listOfNum.count - 1 {
    return listOfNum[index]
  }

  // Find the lowest element in the rest of the array
  let lowest = findLowest(listOfNum: listOfNum, index: index + 1)

  // Check if the element is lower than the current lowest element.
  if listOfNum[index] < lowest {
    return listOfNum[index]
  } else {
    return lowest
  }
}

// Read in lines from input.txt.
let inputFile = URL(fileURLWithPath: "input.txt")
let inputData = try String(contentsOf: inputFile)
let lineArray = inputData.components(separatedBy: .newlines)

// Open the output file for writing.
let outputFile = URL(fileURLWithPath: "output.txt")

// Call function and print to output file.
var minString = ""
var counter = 0
var error = false
while counter < lineArray.count {
  // Convert to int.
  let tempArr = lineArray[counter].components(separatedBy: " ")
  var numArr: [Int] = []
  for location in tempArr {
    // Attempt to convert num.
    do {
      let temp = try convert(strUnconverted: location)
      numArr.append(temp)
    } catch InputError.InvalidInput {
      error = true
    }
  }

  // Check if error has occurred.
  if error {
    print("Cannot convert line to int.")
    minString = minString + "Cannot convert line to int.\n"
    error = false
  } else {
    // Call function.
    let min = findLowest(listOfNum: numArr, index: 0)
    print(min)
    minString = minString + "\(min)\n"
  }

  // Output results.
  try minString.write(to: outputFile, atomically: true, encoding: .utf8)
  counter = counter + 1
}
