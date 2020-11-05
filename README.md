# AALinR
 Average Annualized Loss in R

FEMA collects natural hazards -- flood, hurricane, earthquake, tsunami -- for deterministic events -- such as Katrina, Sandy, Harvey hurricanes, Northridge earthquake to name a few -- and probabilistic from 10 year to 1000 year probability of occurance, which we will call return periods (RPs). This AALinR module assumes the existance of  several (more than 1) probabilistic data points, for the time being, in the predefined RPs [10, 25, 50, 100, 200, 500, 1000], but in the future extendable to any random RP. The import data in space-delimited format is: (ID RP Loss).

The AALinR will produce the Average Annualized Loss using Riemann numerical integration midpoint method. 

Current assumptions are:

- RPs must be one of [10, 20, 50, 100, 200, 500, 1000]
- No missing RP or outlier data detection

Future enhancements:

- Random RP losses
- missing, erroneous, outlier data detection/correction

Why AAL? A: because it is a good measure for relative natural hazards risk of a geographic area.

What is the ID? A: it could be a Census Block (CB), Census Tract (CT), County (CO), State (ST), or individual buildings, for which may have to use Google Plus codes.

Let me know your thoughts.

todorov@chapman.edu