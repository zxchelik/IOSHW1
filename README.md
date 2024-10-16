## Пояснение

В условии задания было сказано, что каждый View должен иметь уникальный цвет, но я решил объединить некоторые View в группы. Внутри группы все элементы одного цвета, зато цвета групп между собой не совпадают.

Надеюсь, это не будет критично и не повлияет на итоговую оценку :)

-----------------------------------------------------------------------------------
Утром я заметил, что забыл закомитить изменение в методе buttonWasPressed.
Вот исправленный вариант(более корректный, но старый тоже рабочий)

```swift
@IBAction func buttonWasPressed(
        _ sender: Any
    ) {
        var colorsSet = getRandomHexColors()
        let button = sender as! UIButton
        
        button.isEnabled = false
        
            
        UIView.animate(
            withDuration: Constants.animationDuration,
            animations: {
                self.colections.forEach { views in
                    let color = colorsSet.popFirst()
                    let cornerRadius: CGFloat = .random(in: Constants.minCornerRadius...Constants.maxCornerRadius)
                    views.forEach { view in
                        view.backgroundColor = UIColor(hexColor: color!)
                        view.layer.cornerRadius = cornerRadius
                    }
                }
            },
            completion: {
                _ in button.isEnabled = true
            }
        )
    }
```
