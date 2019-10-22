#' ---
#' title: "TITLE"
#' author: "Aman Kaur"
#' date: "09/08/2019"
#' ---
#' 
#+ init, message=FALSE,echo=FALSE
# init -----
if(interactive()){
  try(source('https://raw.githubusercontent.com/bokov/UT-Template/master/git_setup.R'));
};

# set to > 0 for verbose initialization
.debug <- 0;
# additional packages to install, if needed. If none needed, should be: ''
.projpackages <- c('GGally','tableone','pander')
# name of this script
.currentscript <- "data_characterization.R"; 
# other scripts which need to run before this one. If none needed, shoule be: ''
.deps <- c( 'dictionary.R' ); 

# load stuff ----
# load project-wide settings, including your personalized config.R
if(.debug>0) source('./scripts/global.R',chdir=T) else {
  .junk<-capture.output(source('./scripts/global.R',chdir=T,echo=F))};

#+ startcode, echo=F, message=FALSE
#===========================================================#
# Your code goes below, content provided only as an example #
#===========================================================#
#' ### Data Dictionary
#' 
#' Quality control, descriptive statistics, etc.

#+ characterization, echo=F, message=FALSE
# characterization ----
#' 
#' * Q: What does the command `nrow()` do?
#'     * A: Gives the number sof rows in the data set
#'          
#'          
#' * Q: What does the command `sample()` do? What are its first and second
#'      arguments for?
#'     * A: Take a sample from a vector of data
#'          
#'          
#' * Q: If `foo` were a data frame, what might the expression `foo[bar,baz]` do,
#'      what are the roles of `bar` and `baz` in that expression, and what would
#'      it mean if you left either of them out of the expression?
#'     * A: 'bar' and 'baz' are the row and column of the dataframe. foo[bar, baz]
#'     will give the value in the corresponding row and column.If either of them ae left 
#'     blank then, for example, if bar(row) is left blank, then all the observations in the 
#'     column will show up.
#'          
#'          
 for(ii in v(c_ordinal)) {dat00[[ii]] <- as.factor(dat00[,ii])}
set.seed(project_seed);
dat01 <- dat00[sample(nrow(dat00), nrow(dat00)/2),];



set.caption('Data Dictionary');
set.alignment(row.names='right');
.oldopt00 <- panderOptions('table.continues');
panderOptions('table.continues','Data Dictionary (continued)');
#  render the Data Dictionary table
pander(dct0[,-1],row.names=dct0$column,split.tables=Inf); 
#  reset this option to its previous value
panderOptions('table.continues',.oldopt00);

#' ### Select predictor and outcome variables
#' 
#' Predictors
predictorvars <- c('time','id','sex');
#' Outcomes
outcomevars <- c('albumin','copper','platelet');
#' All analysis-ready variables
mainvars <- c(outcomevars, predictorvars);

#' ### Scatterplot matrix)
#' 
#' To explore pairwise relationships between all variables of interest.
#+ ggpairs_plot, message=FALSE, warning=FALSE
ggpairs(dat00[,mainvars])

#' ### Cohort Characterization
#' 
#' To explore possible covariates
#Q: Which function 'owns' the argument `caption`? What value does that 
#'      argument pass to that function?
#'     * A: print
#'          
#'          
#' * Q: Which function 'owns' the argument `printToggle`? What value does that 
#'      argument pass to that function?
#'     * A: CreateTableOne
#'          
#'          
#' * Q: Which function 'owns' the argument `vars`? We can see that the value
#'      this argument passes comes from the variable `mainvars`... so what is
#'      the actual value that ends up getting passed to the function?
#'     * A:?. OutcomeVars and Predictovars
#'          
#'          
#' * Q: What is the _very first_ argument of `print()` in the expression below?
#'      (copy-paste only that argument into your answer without including 
#'      anything extra)
#'     * A:(CreateTableOne(vars = mainvars, data = dat01, includeNA = TRUE)
#'     , printToggle=FALSE)
#'          
#' To explore possible covariates
pander(print(CreateTableOne(vars = mainvars, data = dat01, includeNA = TRUE)
             , printToggle=FALSE)
       , caption='Cohort Characterization');

#' ### Data Analysis
#' 
#' Fitting the actual statistical models.
#+ echo=FALSE, message=FALSE
# analysis ----

#+ echo=FALSE,warning=FALSE,message=FALSE
#===========================================================#
##### End of your code, start of boilerplate code ###########
#===========================================================#
knitr::opts_chunk$set(echo = FALSE,warning = FALSE,message=FALSE);

# save out with audit trail ----
message('About to tsave');
tsave(file=paste0(.currentscript,'.rdata'),list=setdiff(ls(),.origfiles)
      ,verbose=FALSE);
message('Done tsaving');

#' ### Audit Trail
.wt <- walktrail();
c()
