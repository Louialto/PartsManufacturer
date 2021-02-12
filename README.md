# PartsManufacturer
The Goal of this project is control the flow of a manufacturing plant based on the anticipated action that is being completed during the 
manufacturing process.
The actions that can be completed include "drilling", "painting", "bolt", "shape".
The constraints are based of what has been completed prior, for example, drill(X): drill a part X, provided X is free (i.e., it is not fastened to any other part).
Therefore, if the product "X" is not already fastened to another part of the product, drill into it. These constraints are anticipated by the cpu for it to be
able to adapt to what the manufacturer needs at real time. 
A program like this would be seen in robotics, more specifically robotic arms in car manufacturing plants. If task is needed to be done and another task is 
complete, do this task and anticipate the next. This is the basics of Artificial Intelligence.
