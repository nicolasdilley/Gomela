# Gomela

To install and use Gomela, follow these steps:


* Run ```git clone http://git.cs.kent.ac.uk/nd315/gomela && cd gomela && go install```
* Put in ``` ./source ``` the folders of the projects that you want Gomela to verify.
* Run ```  go build && ./gomela```


To verify the benchmarks, 

* Run  ```git clone http://git.cs.kent.ac.uk/nd315/gomela && cd gomela && go install && go build```
* Run  ```cp benchmarks/* source && ./gomela```