# Perl-based xDT Parser #

### What is this repository for? ###

* This repository contains a perl project for parsing xDT files.
* Version: 0.1

### How do I get set up? ###

* Summary of set up:
```sh
> sudo -E apt-get install build-essential gfortran tcl git m4 freeglut3 doxygen libblas-dev liblapack-dev libx11-dev libnuma-dev zlib1g-dev libhwloc-dev
> cpan Moose namespace::autoclean XML::Simple
> cpan Test::Class:Moose::Load # for testing
```
* Configuration:
  * The file xDT::Configuration::RecordTypes.xml contains all supported record types and is extensible.
* Dependencies:
  * Moose
  * Test::Class:Moose::Load (optional)
  * namespace::autoclean
  * XML::Simple
* How to run tests:
  * `> prove`
* Deployment instructions:
  * ...

### Contribution guidelines ###

* Write a test module for each xDT module and place it in `/t/lib`
* Clean Code! [1]

### Who do I talk to? ###

* BChristoph
* CrescNet, IMISE

[1] Clean Code: A Handbook of Agile Software Craftsmanship (Robert C. Martin)