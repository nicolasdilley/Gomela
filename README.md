# Automated Verification of Go Programs via Bounded Model Checking

The purpose of this document is to describe in details the steps required to assess the artifact associated to our paper.

This aim is that you are able to: 
  1. Understand how to use our tool so that you can verify your own Go programs.
  2. Reproduce the data of the benchmarks from Figure 9. 
  3. Reproduce the result of the evaluation from Table 1 and Table 2.


### Installing

(This tutorial is primarly intended at Linux/MacOs users)

To use Gomela, there are two main requirement:

The first one is Go, which can downloaded [here](https://golang.org/dl/).
After running the installation, Go will be installed in your home folder.
The second requirement is SPIN. The manual for installation on various OS
can be found [here](http://spinroot.com/spin/Man/README.html#S2).

The third and final requirement is timeout, which is installed natively on linux.

To install timeout on MacOS, 
* ``` brew install coreutils ```


To install Gomela you need to run to run a few commands in the terminal by running :
* ```go get github.com/nicolasdilley/gomela && cd ~/go/src/github.com/nicolasdilley/gomela && go install```

  * This downloads the Gomela project
  * Fetchs all the dependencies and library that it needs to compile.

You then need to compile it by running:
* ```go build```

  * This command generates an executable called ```gomela```. Now, we are ready to run Gomela.


## Step 1 : Understanding and using Gomela

Gomela is a full-scale verification tool that verifies message passing
concurrency in Go programs. Gomela takes either the name of a Go's github
project or a list of Go files as input and generates Promela models. These
models are then fed to SPIN to verify that the models are free of global
deadlocks. Gomela also offers the ability to the user to give bounds to the
statically unknown communication-related parameters in the models to improve
the accuracy of the verification. These parameters are the variables in the
program that affects the number of goroutines or the size of channels in the Go
program.


### Hello world example

To start of we are going to verify a simple concurrent hello world example.

Here is the code:

```
package main

import "fmt"

func main() {
  ch := make(chan string) // creates a channel

  go print(ch, "hello") // spawns a goroutine that will send 'hello' on ch

  fmt.Println(<-ch) // prints what is received from ch

  go print(ch, "world ") // spawns a goroutine that will send 'world' on ch

  fmt.Println(<-ch) // prints what is received from ch
}

func print(ch chan string, toSend string) {
  ch <- toSend // send the value of toSend on ch
}
```

To verify this example, create a file called "hello.go" and paste the code above
in it. Place this file in a newly created folder ```./source``` by running:
* ```mkdir source && mv hello.go source```.
  * The name of the folder (```source``` in this case) does not matter.

When this steps is done, to generate promela models from the Go source and to verify them using SPIN run :
* ```./gomela fs ./source ```

The output of the command line should be:
```
-------------------------------
Result for main_main.pml
Number of states :  29
Time to verify model :  0  ms
Channel safety error : false.
Global deadlock : false.
-------------------------------
```

This tells you that there is neither a safety or a global deadlock in the model.
This also means that there are no safety errors or global deadlocks in the Go
source file ```source/hello.go```.

If we tweak the code to introduce a global deadlock by removing one or both of
the receives on line 10 and 14 and rerun the command ```./gomela ./source -v```.
The output of the command line should be :

```
-------------------------------
Result for main_main.pml
Number of states :  9
Time to verify model :  0  ms
Channel safety error : false.
Global deadlock : true.
-------------------------------
```

This tells you that a global deadlock was found in the model main_main.pml. This
file is named from the concatenation of the name of the package and the name of
the function being modelled. The extension of the file ```.pml``` is used to
specify that it is a Promela file. In the code above, we have specified that the
name of the package was test and the name of the function is main hence
```main_main.pml```.


### Verifying running example "Preload" from paper (Fig. 1)

The function ```Preload``` from the paper in Fig. 1 can be found in [examples/preload_simplifed.go](https://github.com/nicolasdilley/Gomela/blob/rewrite/examples/preload/preload_simplifed.go). 
This function contains a deadlock when 0\<runtime.NumCPU() and 0\<n\<|trees|−1

To verify that the function indeed contains a deadlock, we need to first generate a model:

```./gomela fs examples/preload```

This creates a folder ```./result_current_date``` which contains the Promela model genarated in ```./results_current_data/preload/main++preload8.pml```. (make sure to replace "current_date" with the corresponding date at which the results folder was
created)

If we look inside the model by running 
```cat result_current_date/preload/main++preload8.pml```

we can see that at line 7, 8 and 9, variable var_n8, preload_runtime_NumCPU__, var_trees8 which refers to 
variable n, runtime.NumCPU() and trees respectively in the original program and needs to be given a proper value
because they are mandatory variable. 

These value can be given as argument when verifying the model. 
By given them as arguments of the verify command in the order they appear in the model. 


To verify, the model where n = 1, runtime.NumCPU = 2 and trees = 3, run:

```./gomela verify result_current_date/preload/main++preload8.pml 1 2 3```

The output should be similar to 
```
-------------------------------
Result for result2021-07-13--16:06:46/preload/main++preload8.pml
Number of states :  117
Time to verify model :  4537  ms
Send on close safety error : false.
Close safety error : false.
Negative counter safety error : false.
Double unlock error : false.
Global deadlock : true.
-------------------------------

```

which states that Gomela has found a global deadlock in the model.

To verify a github project: 

``` ./gomela fs s author/project_name``

Ie. to verify [golang/go](https://github.com/golang/go/)

```./gomela fs s golang/go```

The result of the verification will be printed to the terminal as it running.
However, all the results of the verification can be found in  ```./results_current_date/verification.csv```
which reports all the results of the verification of each model extracted from the project.

There is one line per verification. 
A line is composed of: 
  - Column 1: The name of the model
  - Column 2: Whether the verification contained any valued optional parameter (1 if it did, 0 otherwise)
  - Column 3: The number of states in the model 
  - Column 4: The time taken to verify the model
  - Column 5: If a send on close error was found
  - Column 6: If a close safety error was found
  - Column 7: If a negative counter error was found
  - Column 8: If a double lock safety error was found
  - Column 9: If a global deadlock was found
  - Column 10: If there was any error, it would appear here
  - Column 11: The number of communication parameter in the model
  - Column 12: The number of optional parameter in the model
  - Column 13: The name of the communication parameter and their assigned values
  - Column 14: The github link of the original program if it was on github

## Step 2 Reproducing data from benchmark 

To apply Gomela on all benchmarks in the paper simply run: 

``` ./gomela fs benchmarks ```

which will output all the results of the verification.

Those information can also be found in ```results_current_date/verification.csv```
which reports all the results of the verification of each benchmark.

## Step 3 Reproducing data from verifying 99 Github projects. (Table 1 and Table 2) 

The list of projects (along with their commit) can be found in ```./commits.csv```

To automate the verification of the 99 github projects, run:

```./gomela fs l commits.csv```

This will go through each project in ```./commits.csv```, generate all the Promela models and
verify them.

Gomela can also parse the results of the verification to extract: 
  - The 5 stats for the number of models generated per project 
  - The 5 stats for the number of models generated per package 
  - The 5 stats for the number of communication parameters per model
  - The 5 stats of the time taken to verify each project, model and valuation

It can also calculate the 5 stats for the results of all verification or only
for valuation that resulted in a strictly positive score:
  - The 5 stats for the global deadlock found
  - The 5 stats for the channel safety errors found
  - The 5 stats for the waitgroup safety errors found
  - The 5 stats for the mutex safety errors found

To get these run: 
```./gomela full_stats result_current_date/log.csv commits.csv result_current_date/verification.csv```


## Tutorial

[FindAll](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L29) is a function that is found in an open source project called [gops](https://github.com/google/gops) which is a command line tool to diagnose
Go processes. This function contains a bug only when a specific criteria is met.
When the number of ```pss``` in the code is bigger than
```concurrencyProcesses```, the send at line 42 will block when the capacity of
the channel is reached causing a global deadlock.

To verify this function, we will place the code from line 29 - 74 in a folder
called ```source``` and invoke ```./gomela ./source -v```. Gomela will automatically
generate the Promela model and verify it. The promela model generated can be
found [here](https://github.com/nicolasdilley/Gomela/blob/rewrite/examples/findAll.pml) Gomela will generate a model for every function in the program that does not
take a channel as a parameter. In this case, there is only one function that
does not take at least one channel as a parameter and its ```FindAll```. So only
one model will be generated.

As opposed to ```concurrencyProcesses```, the value of ```pss``` (defined at
line 31) in the source code cannot be determined at compile time. As a result,
Gomela gives ```pss``` a default value of 5 to make the model executable. In
this particular example, the default value turns out to be less than
```concurrencyProcesses``` and, therefore, SPIN reports that the model generated
does not result in any global deadlocks. However, if we want to verify the model
with a different value for ```pss```, we can specify to Gomela to give a
different value to ```pss``` by passing a special flag. If we invoke Gomela,
with this command ```./gomela -v -pss=11```. The value of pss will now be 11 and
Gomela will reports that there is a global deadlock in the model.


## Detailed explanations of the model generated.

To understand how Gomela generates Promela models from Go code, here is
an explaination of the model generated by Gomela when invoking ```./gomela```
with the Go code from [FindAll](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L29). The Promela code can be found [here](https://github.com/nicolasdilley/Gomela/blob/rewrite/examples/findAll.pml)

```// /Users/***/go/src/github.com/nicolasdilley/gomela/source/test/test.go
typedef Chandef {
  chan sync = [0] of {int};
  chan async_send = [0] of {int};
  chan async_rcv = [0] of {int};
  chan sending = [0] of {int};
  chan closing = [0] of {bool};
  chan is_closed = [0] of {bool};
  int size = 0;
  int num_msgs = 0;
}

typedef Wgdef {
  chan Add = [0] of {int};
  chan Wait = [0] of {int};
  int Counter = 0;}

}
```

The first line shows the location of the original Go program.The ```typedef Chandef```
is the definition of the channel representation's Gomela uses to model Go's buffered and unbuffered channel. The ```typedef wg``` defines the
structure that is used to model sync.WaitGroup in Promela.

This is followed by the definition of the ```init``` process which contains
the Promela translation of the body of the function ```FindAll```.

```
  Chandef found;
  bool state = false;
  int pss = 5;
  Wgdef wg;
  Chandef limitCh;
  int i;
````

The ```Chandef``` declaration ```found``` and ```limitCh``` are the Promela
channel that represent the Go channel found [here](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L38) and [here](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L39).

The ```Wgdef``` declaration ```wg``` is the Promela WaitGroup that model the
sync.WaitGroup initialiased [here](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L36).

```state``` and ```i``` are place holder variables used to hold the value
received from a channel and to uses as the index of ```for``` loops respectively.


```
  if
  :: true ->
    goto stop_process
  :: true;
  fi;
```

After that, the call ```ps.Processes()``` is ignored because it does not take a
channel as a parameter. This means that it won't impact the communication of the
model unless the call itself is blocking. In that case it is ok because the
function will be verify seperatly if its definition is given.

```if``` statements in Go are translated as a non-deterministic choice between
the two branches. So in this case, from line 8 - 10 in the Go program, the
```if``` statement is translated into a non-deterministic choice between
returning and continuing with the rest of the function's body. the ```return```
statement is translated as a ```goto``` statement which points to the end of the
body of the function.

```
  run wgMonitor(wg);
  wg.Add!pss;
  run sync_monitor(found);

  if
  :: 10 > 0 ->
    limitCh.size = 10;
    run emptyChan(limitCh)
  :: else ->
    run sync_monitor(limitCh)
  fi;
```

After that, the model spawns a monitor for the WaitGroup to monitor and manage
the state of the sync.WaitGroup. The next line models the sync.Waitgroup.Add(x)
which add x to the counter of the WaitGroup by sending that value over the
channel Add. That value is then receive on line 104, added to the counter on
line 105 and a check is done on line 106 to verify that the counter is not
smaller that 0 using the ```assert``` statement in Promela.

To monitor the states of the channels in Promela, we use different monitors
which varies according to the number of messages that the channel contains, if
the channel is closed or not and if it is synchronous or not.

A ```sync_monitor``` is spawned to monitor the channel ```found```.
```sync_monitor``` is used to monitor synchronous channel.

This is followed by an ```if``` statement which spawns a monitor for an
asynchronous channel if the size of the channel ```limitCh``` is bigger than 0
or a synchronous channel if its not. Since the size of ```limitCh``` in the
source code is a constant, the actual value of the constant is given.
```emptyChan``` is used to monitor an empty asynchronous channel.

```
    for(i : 1.. pss) {
for10:
    if
    :: limitCh.async_send!0;
    :: limitCh.sync!0 ->
      limitCh.sending?0
    fi;
    run Anonymous0(found,limitCh,wg)
  };
```

Finally, the ```range``` statement which range over each element in ```pss```
and spawns an anonymous function after sending to limitCh. Since the number of
threads in a Promela model needs to be known at compile time, the value of
```pss``` needs to be known. Therefore, ```pss``` is a communication parameter.
To verify the model with a different value for ```pss```, change the value given
at line 23.

Send and receive statements are translated as a choice between sending or
receiving on an async channel and on a sync channel. This is because as stated
above the size of a channel affects which monitors will be assigned to it.
Sending or receiving on both channel allows to account for both options.

The rest of the models is translated similarly to what has been explained above.


## Further functionalities of Gomela

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



