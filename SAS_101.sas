DATA tutorial_data;
INPUT ID NAME $ SALARY DEPT $ DOJ DATE9.;
FORMAT DOJ DATE9.;
DATALINES;SS
1 ELON 2500 IT 02APR2001
2 STEVE 652 HR 21OCT2000
3 JOE 62 HR 21OCT2000
4 HANS 52 IT 11OCT2000
5 DANNY 100 HR 21OCT1900
6 ALİ 600 IT 21OCT2000
7 AHMET 250 HR 20OCT1950
8 BURAK 650 IT 02OCT1990
9 BURAK 600 IT 16DEC1999
;

PROC CONTENTS DATA=tutorial_data;
RUN;


PROC PRINT DATA=tutorial_data (OBS=5);
VAR NAME SALARY DEPT ;
RUN;

PROC MEANS DATA=tutorial_data KURTOSIS MEAN SUM median std var;
RUN;

PROC UNIVARIATE DATA = tutorial_data NORMAL PLOT 
NORMALTEST;
VAR SALARY;
RUN;

PROC PRINT DATA=tutorial_data;
WHERE (SALARY < 500) OR (DEPT = "%R");
RUN;

PROC SORT DATA=tutorial_data OUT=tutorial_salary;
BY SALARY;
RUN;
PROC PRINT DATA= WORK.tutorial_salary;
RUN;


PROC SORT DATA=tutorial_data OUT=tutorial_salary
 DUPOUT=duplicate_salary
 NODUPKEY;
 BY SALARY ;
RUN ;


PROC SORT DATA=tutorial_data OUT=tutorial_salary
 DUPOUT=duplicate_salary
 NODUPRECS;
 BY SALARY ;
RUN;


DATA new_tutorial_data ;
	SET WORK.tutorial_data;
	new_salary = (SALARY + (SALARY *10)/100);
	KEEP ID NAME new_salary SALARY;
	DROP DOJ;
RUN;


DATA new_tutorial_data;
	SET WORK.tutorial_data;
	new_salary = (SALARY + (SALARY *10)/100);
	sum_salary = SUM(SALARY + new_salary);
	KEEP ID NAME new_salary SALARY sum_salary;
	DROP DOJ;
RUN;





DATA new_if_tutorial_data;
SET WORK.tutorial_data;
	new_salary = (SALARY + (SALARY *10)/100);
	sum_salary = SUM(SALARY + new_salary);
	invoice =' ';
IF (sum_salary <= 500) THEN invoice=0;
ELSE 
invoice=1;

KEEP ID NAME new_salary SALARY sum_salary invoice;
DROP DOJ;
RUN;

PROC PRINT DATA=new_if_tutorial_data;
title1 "Employee Data";
title2 "For XYZ Market";
footnote "TABLO-1";
RUN; 
title;  /* SONRAKİ TABLOLARDA GÖRMEMEK İÇİN KAPATILMASI GEREKİR*/
footnote;



