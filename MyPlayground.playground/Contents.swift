// This is a MacOS Playground
import CreateML
import Foundation

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/William/Dev/Projects/Swift/SleepApp/better-rest.json"))

// test train split
let (trainingData, testingData) = data.randomSplit(by: 0.8)

// Set input and target column from JSON
let regressor = try MLRegressor(trainingData: trainingData, targetColumn: "actualSleep")

let evaluationMetrics = regressor.evaluation(on: testingData)
print("<<<RMSE>>>", evaluationMetrics.rootMeanSquaredError)
print(evaluationMetrics.maximumError)
print("<<<model>>>", regressor.model)
print("<<<description>>", regressor.description)
print("<<<debug description>>>", regressor.debugDescription)

let metadata = MLModelMetadata(author: "William", shortDescription: "A model trained to predict optimum sleep times for coffee drinkers.", version: "1.0")

try regressor.write(to: URL(fileURLWithPath: "/Users/William/Dev/Projects/Swift/SleepApp/SleepModel.mlmodel"), metadata: metadata)

