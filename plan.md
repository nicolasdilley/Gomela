# Introduction (1 week)
  * Model check go source files to find global/partial deadlock and channel safety errors.
  * Explain what is global deadlock and goroutine leaks with example
  * Explain that our aim is to find bugs from real life Go projects and not simple
hand made programs.

# Previous Work (3 days)

  * Talk about previous work, julien ICSE, POPL and other work and what they don't support
  * Talk about SANER paper and what we found
  * Then talk about PLACES and the reason why we did bounded verification.

# Example (3 days)

  * give a concrete example with unknown parameter (File processing from PLACES and FindAll)
and explain why they are challenging

# Promela (3 days)

  * Explain what is Promela and SPIN and why we use Promela.
  * Explain the limitation of Promela and how we countered those limitations when possible.
  (No recursion in inlines, Initialision of channels needs to be at the top of proctype, very slow with increasing number of threads)

# Verification (3 days)

  * What are the bounds that we use, time out values etc.

# Evaluation (2 week - 1 month)


  * Scalability of the tool
  * How many communication params we found per model
  * Number of models per projects
  * How many mand/candidate parameters
  * \# of unsupported models.
  * \# of message passing errors found

  * Applicability of our tool
    ( What we dont support)

# Future Works (1 day)

  * Repair
  * More data with if statements


