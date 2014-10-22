# Primo Date Slider Enhancements

Primo 4 added a date facet with a slider to select the year range.  The default implementation contains a number of usability issues that this script attempts to address.

## Problems we identified:

**Refining by date always adds a new date limiter rather than replacing any existing limiters.**
For example, if you filtered by date three times, you would see three different date ranges applied to your search. This script makes any new date limiters replace the existing date limits rather than applying an additional date limit.

**Every time you press a key in one of the year inputs your cursor moves to the end of the year.**
This was caused by the default javascript behavior.  This script allows you to move your cursor anywhere in the year input fields.

**It is impossible to type a year outside of the initial year range.**
If your have filtered on a year range of 2000-2005 it is impossible to select a year before 2000 or after 2005 without removing the existing year limiter or starting a new search.  This script allows you to type a year in the input fields that is outside of the initial date range.

**The date normalization is restrictive and may not reflect the holdings.**
The years that Primo includes are a static list of 1,500,1000,1500,1600,1700,1800,1900,1910,1920,1930,1940,1950 and then every year from 1951 to the current year.  For example, if you type the year 200, it is changed to 500.  If you type the year 501, it is changed to 1000.

The only change this script makes is if you type a date in the start range, it rounds down instead of up. Typing 1850 in the start field will be changed to 1800, while typing 1850 in the end field will be changed to 1900.

**A couple bonus features!**
In addition to the above fixes this script adds the following:

1. The refine button is hidden until the user does something with the slider or the year input fields.
2. Pressing the enter key while in one of the year input fields will apply the date limit as if you had clicked the button.
