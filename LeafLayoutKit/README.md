#  LeafLayoutKit

```Swift
let firstView = UIView()
let secondView = UIView()

view.addSubview(firstView)
view.addSubview(secondView)

firstView.customLayout(view, [
  .leading(constant: 16),
  .trailing(constant: -16),
  .top(constant: 16),
  .height(constant: view.bounds.midY)
  ]
)

secondView.customLayout(view, [
  .leading(constant: 16),
  .width(constant: 44),
  .height(constant: 44),
  .top(constant: 16, target: firstView, achor: .bottom)
  ]
)

##############
#    [16]    #
#[16]1111[16]#
#    1  1    #
#    1111    #
#    [16]    #
#    22      #
#    22      #
##############


```

  
