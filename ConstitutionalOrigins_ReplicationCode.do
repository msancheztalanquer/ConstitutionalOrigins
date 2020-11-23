

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
/* Negretto, Gabriel and Mariano Sánchez-Talanquer. 							  */
/* Constitutional Origins and Liberal Democracy. A Global Analysis, 1900-2015.    */
/* American Political Science Review.  											  */
/* Annotated Stata replication code for all Tables and Figures in the main        */
/* text and in the online appendix.									  			  */
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


***Obtain and locally save variable labels:
import delimited https://raw.githubusercontent.com/msancheztalanquer/ConstitutionalOrigins/main/labels.csv, varnames(1)

tempname lb
local N = c(N)
file open `lb' using labels.do , write replace
forvalues i = 1/`N' {
    file write `lb' "label variable `= name[`i']' " 
	file write `lb' `""`= varlab[`i']'""' _newline
}
file close `lb'
type labels.do


***Import data set and attach labels to variables: 
import delimited https://raw.githubusercontent.com/msancheztalanquer/ConstitutionalOrigins/main/ConstitutionalOrigins_Data.csv, clear
do labels.do




/*------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------TABLES & FIGURE IN MAIN TEXT------------------------------*/ 


*Declare panel data
xtset constitutionalprocessid yearinconstitutionmaking



***TABLE 3. DiD Estimates of the Effect of Constitution-Making Modalities on Liberal Democracy, 1900 - 2015.

*Column 1. Liberal democracy. All constitutions. Baseline. 
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


**Column 2. Liberal democracy. All constitutions. Adds direct citizen participation variables.
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


**Column 3. Liberal democracy. All constitutions. Adds covariates.
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)

**

*Column 4. Liberal democracy. Constitutions enacted in democratic years. Baseline.
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.yearinconstitutionmaking if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)


*Column 5. Liberal democracy. Constitutions enacted in democratic years. Adds direct citizen participation variables.
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)


*Column 6. Liberal democracy. Constitutions enacted in democratic years. Adds covariates.
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking if democraticconstitution == 1, ///
fe vce (cluster constitutionalprocessid)




****FIGURE 1. Effects of plural approval on liberal democracy per year. Diff-in-diff estimates with 99% and 95% confidence intervals (Model 3, Table 3).
xtreg liberaldemocracy treated_year1-treated_year10 i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)

coefplot, keep(treated_year1 treated_year2 treated_year3 treated_year4 treated_year5 treated_year6 treated_year7 treated_year8 treated_year9 treated_year10) ///
yline(0) vertical levels (99 95) ysc(r(-.1 .2)) ylabel(-.1(.05).2) ytitle("Liberal democracy index") xtitle("Years since enactment")




****TABLE 4. DiD Estimates of the Effect of Constitution-Making Modalities on Executive Constraints, 1900 - 2015

*Column 1. De facto legislative constraints. All constitutions.
xtreg df_legconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 2. De facto legislative constraints. Democratic constitutions.
xtreg df_legconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking if democraticconstitution == 1, ///
fe vce (cluster constitutionalprocessid)


*Column 3. De facto judicial constraints. All constitutions.
xtreg df_juconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 4. De facto judicial constraints. Democratic constitutions.
xtreg df_juconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking if democraticconstitution == 1, ///
fe vce (cluster constitutionalprocessid)


*Column 5. De facto executive constraints. All constitutions.
xtreg executiveconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 6. De facto executive constraints. Democratic constitutions.
xtreg executiveconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking if democraticconstitution == 1, ///
fe vce (cluster constitutionalprocessid)






/*------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-----------------------------------ONLINE APPENDIX----------------------------------*/


*Declare panel data
xtset constitutionalprocessid yearinconstitutionmaking



****TABLE A3. Descriptive statistics

sum liberaldemocracy df_legconstraints df_juconstraints executiveconstraints dj_legpower dj_execpower bicameral upperchamberdominance pluralapproval ///
citizenconsultation citizenvoting ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety if yearinconstitutionmaking != .

sum upperchamberelected if yearinconstitutionmaking != . & bicameral == 1




****TABLE A4. Average liberal democracy index ten years before beginning of constitution-making process and ten years after enactment. Basic difference-in-differences.

reg liberaldemocracy pluralapproval##i.afterconstitution, r 
margins pluralapproval#afterconstitution
margins pluralapproval,dydx(afterconstitution)
margins afterconstitution,dydx(pluralapproval)




****FIGURE A1. Average liberal democracy index with and without plural approval ofnew constitution. Basic diff-in-diff (no controls). Predictions with 95% CIs.

reg liberaldemocracy i.yearinconstitutionmaking##i.pluralapproval, r
margins, at(yearinconstitutionmaking=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) pluralapproval=(0 1))
marginsplot




****TABLE A5. Covariate Balance. Linear probability models.

keep if yearinconstitutionmaking < 11
**Logarithmic-like transformation of age of democracy that allows zero
*Inverse hyperbolic sine (IHS), to deal with extreme value 
gen logageofdemocracy = ln(ageofdemocracy + ((ageofdemocracy^2 +1)^0.5))
collapse (firstnm) country (mean) liberaldemocracy pluralapproval population_log GDPpercapita_log pluralcompetition ///
civilsociety (max) decadeofadoption logageofdemocracy, by(constitutionalprocessid)

foreach var of varlist logageofdemocracy population_log-civilsociety {
		egen z`var' = std(`var')
		reg pluralapproval z`var', r
}

reg pluralapproval ib11.decade, robust




**Note: If data were collapsed to produce TABLE A5, reload full data set here




****TABLE 6. DiD Estimates of the Effect of Constitution-Making Modalities on Liberal Democracy, 1900 - 2015. Ordinal coding of plural approval and direct popular participation variables.

*Column 1. Number of political forces that approved the constitution (1, 2 or 3+). Approval by 2 forces is the omitted category
xtreg liberaldemocracy ib2.pluralapproval_ordinal##i.afterconstitution i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 2. Number of instances of citizen consultation
xtreg liberaldemocracy i.citizenconsultation_ordinal##i.afterconstitution i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 3. Number of instances of citizen voting (referendums)
xtreg liberaldemocracy i.citizenvoting_ordinal##i.afterconstitution i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 4. Plural approval, citizen consultation, and citizen voting (ordinal coding)
xtreg liberaldemocracy ib2.pluralapproval_ordinal##i.afterconstitution i.citizenconsultation_ordinal##i.afterconstitution ///
i.citizenvoting_ordinal##i.afterconstitution i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)




*****TABLE A7. Interacting plural competition with post-enactment period. DiD Estimates of the Effect of Constitution-Making Modalities on Liberal Democracy, 1900 - 2015.

*Column 1. All constitutions.
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log c.pluralcompetition##i.afterconstitution civilsociety i.decade i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 2. Democratic constitutions.
xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log c.pluralcompetition##i.afterconstitution civilsociety i.decade i.yearinconstitutionmaking ///
if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)




*****FIGURE A2. Estimated effect of plural competition on liberal democracy before and after constitution-making. Full sample (all constitutions). 95% CIs.
**All constitutions 

xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log c.pluralcompetition##i.afterconstitution civilsociety i.decade, fe vce (cluster constitutionalprocessid)

margins afterconstitution, at(pluralcompetition=(0(.1)1))
marginsplot, yscale(alt) addplot(hist pluralcompetition, yaxis(2))




****FIGURE A3. Estimated effect of plural competition on liberal democracy before and after constitution making. Restricted sample (constitutions enacted underdemocracy). 95% CIs.
*Democratic constitutions

xtreg liberaldemocracy i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log c.pluralcompetition##i.afterconstitution civilsociety i.decade ///
if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)

margins afterconstitution, at(pluralcompetition=(0(.1)1))
marginsplot, yscale(alt) addplot(hist pluralcompetition if democraticconstitution == 1, yaxis(2))




*****FIGURE A4. Estimated effects of plural versus non-plural approval of newconstitutions on liberal democracy, with 99% and 95% confidence intervals. 
*****Restricted sample (constitutions enacted under democracy). Diff-in-Diff estimates from Table 3, column 6 in the main text.

xtreg liberaldemocracy treated_year1-treated_year10 i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking ///
if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)

coefplot, keep(treated_year1 treated_year2 treated_year3 treated_year4 treated_year5 treated_year6 treated_year7 treated_year8 treated_year9 ///
treated_year10) yline(0) vertical levels (99 95) ysc(r(-.1 .2)) ylabel(-.1(.05).2)




***TABLE A8. Baseline DiD Estimates of the Effect of Constitution-Making Modalities on Executive Constraints, 1900 - 2015.

*Column 1. De facto legislative constraints. All constitutions.
xtreg df_legconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 2. De facto legislative constraints. Democratic constitutions.
xtreg df_legconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)


*Column 3. De facto judicial constraints. All constitutions.
xtreg df_juconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 4. De facto judicial constraints. Democratic constitutions.
xtreg df_juconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)


*Column 3. De facto executive constraints. All constitutions.
xtreg executiveconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 4. De facto executive constraints. Democratic constitutions.
xtreg executiveconstraints i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)




*TABLE A9. DiD Estimates of the Effect of Constitution-Making Modalities on Constitutional Design, 1900 - 2015.

*Column 1. De jure legislative power. All constitutions.
xtreg dj_legpower i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 2. De jure legislative power. Democratic constitutions.
xtreg dj_legpower i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking if democraticconstitution == 1, fe vce (cluster constitutionalprocessid)


*Column 3. De jure executive power. All constitutions.
xtreg dj_execpower i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking if dj_execpower != 0, fe vce (cluster constitutionalprocessid)


*Column 4. De jure executive power. Democratic constitutions.
xtreg dj_execpower i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
ageofdemocracy population_log GDPpercapita_log pluralcompetition civilsociety i.decade i.yearinconstitutionmaking if dj_execpower != 0 & democraticconstitution == 1, fe vce (cluster constitutionalprocessid)





****TABLE A10. Baseline DiD Estimates of the Effect of Constitution-Making Modalities on Bicameralism and Upper-chamberCharacteristics, 1900 - 2015.

*Column 1. Bicameralism.
xtreg bicameral i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


**Column 2. Upper chamber relative dominance
xtreg upperchamberdominance i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)


*Column 3. % of directly elected upper chamber members
xtreg upperchamberelected i.pluralapproval##i.afterconstitution i.citizenconsultation##i.afterconstitution i.citizenvoting##i.afterconstitution ///
i.yearinconstitutionmaking if bicameral == 1, fe vce (cluster constitutionalprocessid)




***FIGURE A5. Feasibility of the Parallel Trends Assumption. 95% CI

xtreg liberaldemocracy quinquennium1 quinquennium3 quinquennium4 quinquennium1_pluralapproval quinquennium3_pluralapproval quinquennium4_pluralapproval, ///
i(constitutionalprocessid) cluster(constitutionalprocessid) fe level(95)
coefplot, keep(quinquennium*_pluralapproval) vertical level(95) yline(0) xline(1.5) ytitle("Parameter estimate")




***FIGURE A6. Placebo test

xtreg liberaldemocracy treated_placeboyear1-treated_placeboyear5 i.yearinconstitutionmaking, fe vce (cluster constitutionalprocessid)

coefplot, keep(treated_placeboyear*) vertical level(95) yline(0) ytitle("Parameter estimate")

