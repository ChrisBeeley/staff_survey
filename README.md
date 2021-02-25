# staff_survey

A {golem} powered summary of some free text survey data from staff.

Having summary tables of categorised free text data is something I do over and over again and this is an attempt to produce something that is reusable and properly factored so I can port it to other applications easily. I have also included some rudimentary tests and split the tables and the text summaries into different modules.

One way hashed data is included to make it work, the real thing includes verbatim comments. The criticality scores have also been randomised so as to not reveal the real values of whether people feel positively or negatively about the stuff from the survey.

Install the package with

```
remotes::install_github("ChrisBeeley/staff_survey")
```

And run with 

```
library(staffSurveyNew)
run_app()
```
