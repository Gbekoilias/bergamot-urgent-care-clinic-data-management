* Define the dataset.
DATA LIST FREE / value.
BEGIN DATA
10
20
20
40
50
END DATA.

* Compute descriptive statistics.
DESCRIPTIVES VARIABLES=value
  /STATISTICS=MEAN MEDIAN MODE STDDEV.

* Calculate mean, median, mode, and standard deviation.
* The results will be displayed in the output window.

* Hypothesis Testing: One-Sample Z-Test.
* Assume population mean is 30 and alpha level is 0.05.
COMPUTE population_mean = 30.
COMPUTE alpha = 0.05.

* Calculate sample size and sample mean.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /n = N(value)
  /sample_mean = MEAN(value).

* Calculate standard deviation for the sample.
DESCRIPTIVES VARIABLES=value
  /STATISTICS=STDDEV.

* Compute z-score.
COMPUTE z_score = (sample_mean - population_mean) / (STDDEV(value) / SQRT(n)).

* Determine critical value for z at alpha level of 0.05 (two-tailed).
COMPUTE critical_value = 1.96.  /* For a two-tailed test at alpha = 0.05 */

* Check if null hypothesis is rejected.
COMPUTE result = (ABS(z_score) > critical_value).
VALUE LABELS result 0 'Fail to Reject Null Hypothesis' 1 'Reject Null Hypothesis'.

* Display results of hypothesis test.
FREQUENCIES VARIABLES=result.

* Linear Regression Example.
DATA LIST FREE / x y.
BEGIN DATA
1 10
2 20
3 20
4 40
5 50
END DATA.

* Perform linear regression.
REGRESSION
  /DEPENDENT y
  /METHOD=ENTER x.

* The output will display the regression coefficients (slope and intercept).
