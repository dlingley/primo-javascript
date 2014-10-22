# Ex Libris Primo JavaScript Files

This is a collection of miscellaneous JavaScript files to enhance the Primo 4 user experience.

The scripts are written in CoffeeScript in the [coffeescript](coffeescript) directory and automatically compiled to JavaScript in the [javascript](javascript) directory.

In order to use a script you can download the .js version of the file, copy it to your Primo application, and add a `<script>` tag that includes the file.

## send-to-links

Primo has a helpful dropdown of links providing features such as email, print, citation, permalink, etc.  By default this dropdown is only available after clicking on a record's detail tab.  This script adds a version of the dropdown links at the record level so users can access the functionality without clicking on the detail tab.

## fix-dateslider

Primo 4 added a date facet with a slider to select the year range.  The default implementation contains a number of usability issues that this script attempts to address. [Read More](docs/fix-dateslider.md)
