# Gomela

To install and use Gomela, follow these steps:


* Run ```go get github.com/nicolasdilley/gomela && cd ~/go/src/github.com/nicolasdilley/gomela && go install```
* Put in ``` ./source ``` the folders of the projects that you want Gomela to verify.
* Run ```  go build && ./gomela```


To verify the benchmarks, 

* Run  ```git clone http://git.cs.kent.ac.uk/nicolasdilley/gomela && cd gomela && go install && go build```
* Run  ```cp benchmarks/* source && ./gomela```
