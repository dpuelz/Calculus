# Calculus I

Welcome to the Winter 2026 edition of Calculus I (STM 1001, 4.5 credits)! All course materials can be found on this GitHub page. Please see the [course syllabus](syllabus/course_outline.pdf) for links and descriptions of the readings mentioned below.

**Instructor:**  
- Prof. David Puelz. Individual meetings can be booked at the following [link](https://calendly.com/dpuelz). Office hours: Please consult the webpage.

**Email:** [dpuelz@uaustin.org](mailto:dpuelz@uaustin.org)

**Meeting Schedule:** M/W/F from 11:30a-12:45p

## Course Description

Calculus drives our understanding of change and motion, powering modern science, technology, and data-driven fields from physics to AI. This course reinvents how we learn calculus by blending computing, modeling, and statistics, using R-based computation to make ideas directly relevant to the digital age. Students will move beyond rote symbolic work to apply calculus in real-world modeling and analysis, building the skills needed for modern scientific and analytical thinking.

## Course Objectives

- Understand and apply functions as tools for mathematical modeling
- Use computational methods to explore and analyze mathematical relationships
- Master differentiation and apply it to solve optimization problems
- Develop skills in mathematical analysis and approximation techniques

## Required Readings

- _Mathematical Modeling and Applied Calculus_ (MMAC) -- Alex M. McAllister and Joel Kilty
- [_Mosaic Calculus_](https://www.mosaic-web.org/MOSAIC-Calculus/) (MC) -- Danny Kaplan (Available online)

## Assignments

There will be 5 homework assignments to be turned in via Populi. They will be posted here.

- [Homework 1](assignments/HW1.pdf). Due Friday, Jan 16 at 11:30a.
- [Homework 2](assignments/HW2.pdf). Due Friday, Jan 30 at 11:30a.
  - Data: [Austin restaurants dataset](data/austin_restaurants.csv)
- [Homework 3](assignments/HW3.pdf). Due Friday, Feb 13 at 11:30a.
- [Homework 4](assignments/HW4.pdf). Due Friday, Feb 27 at 11:30a.
- [Homework 5](assignments/HW5.pdf). Due Friday, Mar 13 at 11:30a.

### Notes and Solutions

- [HW4 Problem 5: Gradient Descent and a Simple Neuron — Solution](notes/HW4_Problem5_solution.pdf)

### Homework Rubric

1 = All answers incorrect or inadequately addressed and missing deliverables, severely lacking clarity, write-up unprofessional

2 = More than half of answers incorrect, severely lacking clarity, write-up unprofessional and/or missing deliverables

3 = The majority of answers are correct with a couple mistakes, write-up is not professionally compiled but legible

4 = All answers are correct and write-up is acceptable. This is the modal grade

5 = All answers are correct and write-up is exceptional. The student went above and beyond the prompts to investigate an area not explicitly requested

## Quizzes

There will be 5 quizzes on the Fridays of weeks 2, 4, 6, 8, and 10. The quizzes will be related to the homework, and we will mark up the quizzes in class directly after finishing the quiz.

- Quiz 1: Week 2, Friday (Jan 16)
- Quiz 2: Week 4, Friday (Jan 30)
- Quiz 3: Week 6, Friday (Feb 13)
- Quiz 4: Week 8, Friday (Feb 27)
- Quiz 5: Week 10, Friday (Mar 13)

## Final Exam

The final exam will be held during the scheduled exam time (week 11 of the course).

## Software

### Local R (downloadable software on your computer)

You will need a local download of R to run our example code and for your assignments. Please install [R](https://cran.rstudio.com) and then [RStudio](https://posit.co/download/rstudio-desktop/) on your own computer (you want the "RStudio Desktop" version). Both are free and work on all platforms. R is the underlying data-analysis program we'll use in this course, while RStudio provides a nice front-end interface to R that makes certain repetitive steps (e.g. loading data, saving plots) very simple.

## Course Cadence

There will be 5 quizzes and 5 homework assignments. The quizzes will be on the Fridays of weeks 2, 4, 6, 8, and 10. The homeworks will be due on Fridays at 11:30a (start of class) on the same days as the quizzes. The quiz content will be related to the homework, and we will mark up the quizzes in class directly after finishing the quiz. We will have a final exam during the scheduled exam time (on week 11 of the course).

## Rough Schedule

| Week | Topics | Reading |
|------|--------|---------|
| 1 (Jan 5) | Functions, notation, R basics, visualization | MC: 1-4; MMAC: §1.1-1.7 |
| 2 (Jan 12) | Pattern-book functions and data | MC: 5-7; MMAC: §1.1-1.7 |
| 3 (Jan 19) | Parameters, assembling functions, multivariable | MC: 8-10; MMAC: §1.2, §2.1-2.2 |
| 4 (Jan 26) | Fitting, polynomials, dimensions & units | MC: 11-16; MMAC: §2.3-2.4, §1.5, §2.5 |
| 5 (Feb 2) | Continuous change, rate of change, evanescent h | MC: 17-19; MMAC: §3.1-3.3 |
| 6 (Feb 9) | Constructing derivatives, concavity, smoothness | MC: 20-22; MMAC: §4.1-4.3, §3.4 |
| 7 (Feb 16) | Partial derivatives, gradients | MC: 23-24; MMAC: §4.4-4.5, §5.1-5.2 |
| 8 (Feb 23) | Multivariable optimization | MC: 24-26; MMAC: §5.3-5.4 |
| 9 (Mar 2) | Gradient descent | MC: 27; MMAC: Ch. 7 |
| 10 (Mar 9) | Review and synthesis | MC: 27; MMAC: Ch. 7 |
| 11 (Mar 16) | **Final exam week** | |

## Outline of Topics

The sections below are keyed to the **Rough Schedule**. Each block lists which weeks it covers and the materials we use in class.

### (0) Introduction and Functions (computing, pattern-book functions, visualization, and data)

**Schedule:** Weeks 1–2 ([HW1](assignments/HW1.pdf) due Friday of Week 2)

Slides: [Functions, Computing & Pattern-Book Functions](slides/lecture-functions_patterns.pdf)

Lecture Notes:
- [Lecture 01: Pattern-Book Functions](lectures/lecture01_pattern_book_functions.pdf)
- [Lecture 02: Visualizing Functions](lectures/lecture02_visualizing_functions.pdf)
- [Lecture 03: Describing Functions](lectures/lecture03_describing_functions.pdf)

Code for class:
- [Introduction to R](code/intro_to_R.R)
- [Introduction to Functions](code/intro_functions.R)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 1-7
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §1.1-1.7

### (1) Parameters, Assembling Functions, and Multivariable Functions

**Schedule:** Week 3

Lecture Notes:
- [Lecture 04: Parameters](lectures/lecture04_parameters.pdf)
- [Lecture 05: Assembling Functions](lectures/lecture05_assembling_functions.pdf)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 8-10
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §1.2, §2.1-2.2

Code for class:
- [TBA](code/)

### (2) Fitting, Polynomials, Dimensions & Units

**Schedule:** Week 4 ([HW2](assignments/HW2.pdf) due Friday—data: [Austin restaurants](data/austin_restaurants.csv))

Lecture Notes:
- [Lecture 06: Dimensions and Units](lectures/lecture06_dimensions_units.pdf)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 11-16
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §2.3-2.4, §1.5, §2.5

Code for class:
- [TBA](code/)

### (3) Continuous Change, Rate of Change, Evanescent h

**Schedule:** Week 5

Lecture Notes:
- [Lecture 07: Galileo and the Discovery of Continuous Change](lectures/lecture07_galileo_increments.pdf)
- [Lecture 08: The Derivative — Instantaneous Rate of Change](lectures/lecture08_derivative.pdf)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 17-19
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §3.1-3.3

Code for class:
- [Increments, rate of change, and secant segments](code/increments_rate_of_change.R)

### (4) Constructing Derivatives, Concavity, Smoothness

**Schedule:** Week 6

Lecture Notes:
- [Lecture 09: Derivative Notation and Applications](lectures/lecture09_applications.pdf)
- [Lecture 10: Constructing Derivatives](lectures/lecture10_constructing_derivatives.pdf)
- [Lecture 11: Concavity and the Second Derivative](lectures/lecture11_concavity_2ndderivative.pdf)
- [Lecture 12: Continuity and Smoothness](lectures/lecture12_continuity_smoothness.pdf)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 20-22
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §4.1-4.3, §3.4

Code for class:
- [TBA](code/)

### (5) Partial Derivatives and Gradients

**Schedule:** Week 7

Lecture Notes:
- [Lecture 13: Partial Derivatives and Gradients](lectures/lecture13_partial_derivatives_gradients.pdf)

Code for class:
- [Partial Derivatives and Gradients](code/lecture13_partial_derivatives_gradients.R)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 23-24
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §4.4-4.5, §5.1-5.2

### (6) Multivariable Optimization

**Schedule:** Week 8 ([HW4](assignments/HW4.pdf) due Friday of Week 8)

Lecture Notes:
- [Lecture 14: Multivariable Optimization](lectures/lecture14_optimization.pdf)

Code for class:
- [Multivariable Optimization](code/optimization.R)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 24-26
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §5.3-5.4

### (7) Gradient Descent and Review and Synthesis

**Schedule:** Weeks 9–10

Slides (presentation):
- [Neural Networks: A Calculus Perspective](slides/neural-networks-calculus.pdf) — chain rule, gradients, backpropagation (high-level)

Python notebooks (companion to neural network slides):
- [basic_nn.ipynb](code/basic_nn.ipynb), [classification_nn.ipynb](code/classification_nn.ipynb), [MNIST.ipynb](code/MNIST.ipynb)

Lecture Notes:
- [Lecture 15: The Gradient Maximizes the Directional Derivative](lectures/lecture15_gradient_maximizes_directional_derivative.pdf)
- [Lecture 16: Gradient Descent Worked Examples](lectures/lecture16_gradient_descent.pdf)

Code for class:
- [Gradient Descent Examples](code/gradient_descent_examples.R)

Readings:
- _Mosaic Calculus_ (MC) -- Chapter 27
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- Ch. 7
