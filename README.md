# Substitution Model over-parameterization

Bayesian phylogenetic inference with substitution model over-parameterization.
Scripts used in the paper: *Bayesian inference of phylogeny is robust to substitution model over-parameterization*


Installing RevBayes
=================

The functions and methods used in this tutorial are implemented in the software RevBayes.

To install: [`RevBayes`](https://revbayes.github.io/).

Installing Convenience
=================

You can install the package using devtools:
  
  > `install.packages("devtools")` <br />
  > `library(devtools)` <br />
  > `install_github("lfabreti/convenience")` <br />
  > `library(convenience)` <br />

Simulating datasets
=================

We will simulate 100 alignments under the Jukes-Cantor model, for each of the eight simulation scenarios described in the paper (Table 1).

From the `scripts` folder, run the script `simulate_JC.Rev` with the command:

  rb simulate_JC.Rev

You should see two new folders called `data_sim_trees` and `data_sim_alignments`. Inside each folder there are another eight folders, each for a specific simulation scenario.

Full analysis
=================

The full analysis pipeline is in the script `full_analysis.sh`. It can be run, from the main folder, with the command:

   bash full_analysis.sh
