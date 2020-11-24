# Abstract (22 -> 25 january)

# Introduction (14 -> 21 january)
  * Model check go source files to find global/partial deadlock and channel safety errors.
  * Explain what is global deadlock and goroutine leaks with example
  * Explain that our aim is to find bugs from real life Go projects and not simple
hand made programs.

# Previous Work (11 -> 14 january)

  * Talk about previous work, julien ICSE, POPL and other work and what they don't support
  * Talk about SANER paper and what we found
  * Then talk about PLACES and the reason why we did bounded verification.

# Example (30 novembre -> 3 december)

  * give a concrete example with unknown parameter (File processing from PLACES and FindAll)
and explain why they are challenging

# Promela (3 -> 8 december)

  * Explain what is Promela and SPIN and why we use Promela.
  * Explain the limitation of Promela and how we countered those limitations when possible.
  (No recursion in inlines, Initialision of channels needs to be at the top of proctype, very slow with increasing number of threads)

# Verification (8 -> 11 december)

  * What are the bounds that we use, time out values etc.
  * Generation of automatic values for mandatory parameters.
  * When bug found, allow more precision by giving automatic values to optional parameters
  * superseed function, which test if a given list of values is superseeded by values from previous run, to reduce number of tests

# Evaluation (11 december -> 11 january)
  * Scalability of the tool
  * How many communication params we found per model
  * Number of models per projects
  * How many mand/candidate parameters
  * \# of unsupported models.
  * \# of message passing errors found

  * Applicability of our tool
    ( What we dont support)

# Future Works (21 -> 22 january)

  * Repair
  * More data with if statements




Improving and review of paper (25 -> 29 january)



Timeline

Example (30 novembre -> 3 december)
Promela (3 -> 8 december)
Verification (8 -> 11 december)
Evaluation (11 december -> 11 january)
Previous Work (11 -> 14 january)
Introduction (14 -> 21 january)
Future Works (21 -> 22 january)
Abstract (22 -> 25 january)
Improving and review of paper (25 -> 29 january)
