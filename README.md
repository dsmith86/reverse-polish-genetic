Artificial Genetic Recombination of Chromosomes, v0.1
======================
(WIP) A simulation of genetic recombination through [chromosomal crossover](http://en.wikipedia.org/wiki/Chromosomal_crossover "Chromosomal crossover - Wikipedia") by selecting for mathematical expressions in Reverse Polish Notation.

###Purpose:
Genetic algorithms have been a subject of intense interest for me for several years. I've been wowed by impressive demonstrations of machine learning and artificial adaptation as demonstrated by people like Karl Sims ([YouTube link](https://www.youtube.com/watch?v=bBt0imn77Zg "Karl Sims - Evolving Virtual Creatures With Genetic Algorithms")). I recently did some reading on how these feats are accomplished, and I had the idea for this project: To create a genetic algorithm that would select for sets of chromosomes that express mathematical expressions in [Reverse Polish Notation](http://en.wikipedia.org/wiki/Reverse_Polish_notation "Reverse Polish notation - Wikipedia"). The following is a general overview of the project so far:

The project is currently incomplete, but I will continue to add commits when I have free time from work and class. So far, I have a class for generating the target number (described below), as well as a binary-to-RPN calculator class.

###Procedure:
So far, I've devised the following general procedure for this project:

1. The number of operands to be used is decided ([more info](#eq_operands "Number of chromosomes")) (Default: 2).
2. A random target number is generated using the equation described [here](#eq_target "Generating a target number").
3. The number of bytes needed is determined using the equation described [here](#eq_bitcount "Determining the bitcount").
4. Each organism in the simulation is created with a random bit sequence as described in the previous step.
5. The fitness of each organism is determined by an equation described [here](#eq_fitness "Calculating fitness levels"). This fitness level is based on the chromosomes' representation of the aforementioned mathematical expression, which is compared against the target number.
6. Organisms with statistically higher fitness levels will be more likely to be chosen in the current generation's round of reproduction. Errors in representing mathematical expressions for RPN will result in a severe statistical disadvantage.
7. Organisms are paired and prepare to recombine copies their chromosomes up to twice.
   NOTE: Up to one random mutation may occur at this point for each set of chromosomes. The likelihood of this will be minute (ex: 0.001).
8. Chromosomal crossover occurs between two organisms after a randomly chosen number of chromoses (that is, after a certain point, the remaining bit sequences are swapped between the organisms).
9. These new chromosomes are then used to spawn new organisms.
10. When a maximum population is achieved, organisms from previous generations will be deleted from the simulation after reproduction to prevent processing strains on the simulation.
11. Each successive generation is then evaluated as per step 5, and so on.
12. Eventually, an organism whose chromosomes perfectly define the correct mathematical expression for the given target number (without errors in syntax) will arise, and the simulation will conclude.


###Equations:
<a name="eq_operands"></a>
####Number of chromosomes
The total number chromosomes (represented by four bits of information) can be expressed by the following equation:

C<sub>tot</sub> = (C<sub>opd</sub> + C<sub>opt</sub>),

where C<sub>tot</sub> is the total number of chromosomes, C<sub>opd</sub> is the number of chromosomes that represent operands, and C<sub>opt</sub>, the number of chromosomes that represent operators, can be expressed as

C<sub>opt</sub> = C<sub>opd</sub> - 1.

Therefore, the original equation can be expressed as

C<sub>tot</sub> = (C<sub>opd</sub> * 2 - 1).

<a name="eq_target"></a>
####Generating a target number
The target number can be any random integer between 0 and 9<sup>C<sub>opd</sub></sup>. For example, with 3 operands, the binary sequence yielding the highest possible target number would be 10011001100111001100, which would be translated by [RPNCalc](https://github.com/dsmith86/reverse-polish-genetic/blob/master/lib/AGRoC/RPNCalc.rb "RPNCalc.rb") as 9 9 9 * *. Thus, 9<sup>C<sub>opd</sub></sup> is the maximum value possible because 9 is the highest possible operand, and multiplication is the most impactful operator.

<a name="eq_bitcount"></a>
####Determining the bitcount
The bitcount is simply the [number of chromosomes](#eq_operands "Number of chromosomes"), multiplied by 4 (the number of bits per chromosome in this scenario). That is,

B<sub>tot</sub> = 4(C<sub>tot</sub>),

where B<sub>tot</sub> is the total number of bits in the sequence.


<a name="eq_fitness"></a>
####Calculating fitness levels
Fitness levels can be expressed by the following equation:

F = Diff<sup>-1</sup> = 1/(Diff),

where F is the fitness level (expressed as a floating-point number) and Diff is the difference between the target number and the value of the mathematical expression represented by an organism's chromosomes. An invalid bit sequence (that is, one that invokes an error during calculation) will reduce the organism's fitness level by a factor of 2. Therefore, the fitness level for an error-producing organism can be expressed as

F<sub>err</sub> = 0.5(Diff<sup>-1</sup>) = 1/(2Diff).

###Instructions for the test program:
if you have ruby installed, simply run

```sh
sudo gem install rake
```

to install Rake, which can be used to run Rakefiles.
Then, clone this repository, navigate to the project directory, and run

```sh
rake
```

to run the test program. Alternately, you can run the test program manually:

```sh
ruby test/test.rb
```

Note about LICENSING:
I will be using the [Unlicense](http://unlicense.org/) for this project, because I don't care what you do with it. Feel free to use it in any way you see fit. I'm working on this project for practice and fun, anyways. Feel free to contribute to this project with Pull Requests and by issuing Issues.


#####Author:
Daniel Smith
#####Start Date:
5/3/2014
#####Contact:
d.lake.smith@eagles.usm.edu
