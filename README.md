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
- <span style="color: gray;">Homework 3. Due Friday, Feb 13 at 11:30a.</span>
- <span style="color: gray;">Homework 4. Due Friday, Feb 27 at 11:30a.</span>
- <span style="color: gray;">Homework 5. Due Friday, Mar 13 at 11:30a.</span>

## Data

- [Austin restaurants dataset](data/austin_restaurants.csv)

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
| 4 (Jan 26) | Fitting, polynomials, dimensions & units | MC: 11-16; MMAC: §2.3-2.5 |
| 5 (Feb 2) | Continuous change, rate of change, evanescent h | MC: 17-19; MMAC: §3.1-3.3 |
| 6 (Feb 9) | Constructing derivatives, concavity, smoothness | MC: 20-22; MMAC: §4.1-4.3, §3.4 |
| 7 (Feb 16) | Derivatives of assembled functions, optimization | MC: 23-24; MMAC: §4.4-4.5, §5.1-5.2 |
| 8 (Feb 23) | Optimization, partial derivatives, gradients | MC: 24-26; MMAC: §5.3-5.4 |
| 9 (Mar 2) | Taylor polynomials, review & synthesis | MC: 27; MMAC: Ch. 7 |
| 10 (Mar 9) | Review and synthesis | MC: 27; MMAC: Ch. 7 |
| 11 (Mar 16) | **Final exam week** | |

## Outline of Topics

### (0) Introduction and Functions (computing, pattern-book functions, visualization, and data)

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

Slides: [TBA](slides/)

Lecture Notes:
- [Lecture 04: Parameters](lectures/lecture04_parameters.pdf)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 8-10
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §1.2, §2.1-2.2

Code for class:
- [TBA](code/)

### (2) Fitting, Polynomials, Dimensions & Units

Slides: [TBA](slides/)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 11-16
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §2.3-2.5

Code for class:
- [TBA](code/)

### (3) Continuous Change, Rate of Change, Evanescent h

Slides: [TBA](slides/)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 17-19
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §3.1-3.3

Code for class:
- [TBA](code/)

### (4) Constructing Derivatives, Concavity, Smoothness

Slides: [TBA](slides/)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 20-22
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §4.1-4.3, §3.4

Code for class:
- [TBA](code/)

### (5) Derivatives of Assembled Functions, Optimization

Slides: [TBA](slides/)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 23-24
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §4.4-4.5, §5.1-5.2

Code for class:
- [TBA](code/)

### (6) Optimization, Partial Derivatives, Gradients

Slides: [TBA](slides/)

Readings:
- _Mosaic Calculus_ (MC) -- Chapters 24-26
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- §5.3-5.4

Code for class:
- [TBA](code/)

### (7) Taylor Polynomials and Synthesis

Slides: [TBA](slides/)

Readings:
- _Mosaic Calculus_ (MC) -- Chapter 27
- _Mathematical Modeling and Applied Calculus_ (MMAC) -- Ch. 7

Code for class:
- [TBA](code/)
