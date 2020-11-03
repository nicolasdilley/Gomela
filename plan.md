# Introduction
  * Model check go source files to find message passing concurrency related bug.
  * Explain the message passing concurrency errors that we verify.
  * Explain that our aim is to find bugs from real life Go projects and not simple
hand made programs.

# Previous Work

  * Talk about previous work, julien ICSE, POPL and other work and what they don't support
  * Talk about SANER paper and what we found
  * Then talk about PLACES and the reason why we did bounded verification.

# Example

  * give a concrete example with unknown parameter (File processing from PLACES and FindAll)
and explain why they are challenging

# Minigo
  * Explain Minigo and what we actually support.
  * Explain why we don't support Map of channels, pointers, channels returned by function etc.

# Promela

  * Explain what is Promela and SPIN and why we use Promela.
  * Explain the limitation of Promela and how we countered those limitations when possible. (No recursion in inlines, Initialision of channels needs to be at the top of proctype, very slow with increasing number of threads)

# Verification

  * What are the bounds that we use, time out values etc.

# Evaluation


  * Scalability of the tool
  * How many communication params we found per model
  * Number of models per projects
  * How many mand/candidate parameters
  * \# of unsupported models.
  * \# of message passing errors found

  * Applicability of our tool
    ( What we dont support)

# Future Works

  * Explain what we are planning to do.
  * Communication parameters.
  * Large scale verification of our theory on real world projects.


