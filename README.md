# Gomela

To install and use Gomela, follow these steps:


* Run ```go get github.com/nicolasdilley/gomela && cd ~/go/src/github.com/nicolasdilley/gomela && go install```
* Put in ``` ./source ``` the folders of the projects that you want Gomela to verify.
* Run ```  go build && ./gomela```

To pass a default lower and upper bound for badly formed for loop (including infinite for loops)
use the flags ```-lb=value``` and ```-ub=value``` to give a default ```value``` for the lower and upper bound respectively.

To verify the benchmarks:

* Run  ```git clone http://git.cs.kent.ac.uk/nicolasdilley/gomela && cd gomela && go install && go build```
* Run  ```cp benchmarks/* source && ./gomela```

To verify a list of projects:

* Create a .txt file containing all the github projects that you want to verify with each project name (in the form "creator/project_name") on a seperate line. (see [projects.txt](https://www.github.com/nicolasdilley/Gomela/projects.txt))
* Run ```./gomela -l projects.txt -r```
* The results of the survey (log.html and log.csv) will be contained in ./results with a folder per project containing the Promela models.

To verify a single github repository:

* Run ```./gomela -s creator/project_name -r``` ig. ```./gomela -s nicolasdilley/Gomela -r``` will verify this project.
* The result of the survey will be in ./result and the Promela models under ./results/project_name/\*.pml.


The name of the Promela models are as follow: model_nameOfFuction.pml


The features analysed in the survey are :

* Chan in for - A channel created in a for loop
* Go in for - A goroutine is spawned in a for loop
* Comm Param - A function's parameter that is used as either a for loop bound or a channel bound
* For loop not well formed - A for loop that is not well formed (nor infinite)
* Func as a bound - A for loop has a function as a bound
* Receive as a bound - A for loop has a receive as a bound
* len() as a bound - A bound that is the length of a list
* Struct as a bound - A bound that is of type Struct
* Elem of a struct as a bound - A bound that is an element of a struct (eg, b.a)
* Uses an item of a list as a bound - A bound that is an element of a list (eg, a[0])
* Pointer as a bound - A bound that is a pointer (eg, &a[0], &a)
* Integer as a bound - A bound that is a constant or an Integer (eg, a -> const a := 10, 10)
* Var as a bound - A bound that is a variable(eg, a -> a := 10)
