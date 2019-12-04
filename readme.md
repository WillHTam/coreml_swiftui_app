## Sleep CoreML App
### Simple deployment of a CoreML model into an app

https://developer.apple.com/documentation/createml/mlregressor 

mlmodel uses LinReg, was automatically chosen by MLRegressor

see regressor.description after running .evaluate 

```
.presentation($showingAlert) {
    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
}
```

changed in SwiftUI to 

```
.alert(isPresented: $showingAlert) {
    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
}
```
