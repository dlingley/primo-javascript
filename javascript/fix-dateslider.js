(function() {
  jQuery(function($) {
    var $dateSubmit, $end, $slider, $sliderURL, $start, addEventHandlers, addYear, allowedYears, getURL, gotoURL, hideLink, maxYear, minYear, nearestYear, padYear, ready, recentYears, removePreviousDates, restrictKeyPress, restrictKeyUp, showLink, sortNumber, submitEnd, submitStart, updateEnd, updateSlider, updateStart, updateURL, yearIndex, yearValue, years, _i, _results;
    $slider = $('#slider-range');
    if ($slider.length > 0) {
      $sliderURL = $("#sliderURL");
      $start = $('#startdate');
      $end = $('#enddate');
      $dateSubmit = $('#dateSubmit');
      minYear = 1;
      maxYear = new Date().getFullYear();
      years = window.limits;
      recentYears = (function() {
        _results = [];
        for (var _i = 1951; 1951 <= maxYear ? _i <= maxYear : _i >= maxYear; 1951 <= maxYear ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this);
      allowedYears = $.merge([1, 500, 1000, 1500, 1600, 1700, 1800, 1900, 1910, 1920, 1930, 1940, 1950], recentYears);
      removePreviousDates = function() {
        var modifiedURL, nameMatches, originalURL, valueMatches;
        originalURL = $sliderURL.val();
        modifiedURL = originalURL;
        nameMatches = originalURL.match(/fctN=[^&]+&?/g);
        valueMatches = originalURL.match(/fctV=[^&]+&?/g);
        $.each(nameMatches, function(index, nameMatch) {
          var valueMatch;
          if (nameMatch.match(RegExp("=facet_creationdate"))) {
            valueMatch = valueMatches[index];
            modifiedURL = modifiedURL.replace(nameMatch, "");
            modifiedURL = modifiedURL.replace(valueMatch, "");
          }
        });
        return $sliderURL.val(modifiedURL);
      };
      hideLink = function() {
        $dateSubmit.hide();
      };
      showLink = function() {
        $dateSubmit.show();
      };
      getURL = function() {
        var dateString, url;
        showLink();
        url = $sliderURL.val();
        url = url.replace('fctN=xxx', "fctN=facet_creationdate");
        dateString = "fctV=%5b" + (padYear($start.val())) + "+TO+" + (padYear($end.val())) + "%5d";
        url = url.replace('fctV=xxx', dateString);
        return url;
      };
      padYear = function(year) {
        var pad;
        year = '' + year;
        pad = "0000";
        return pad.substring(0, pad.length - year.length) + year;
      };
      updateURL = function() {
        $dateSubmit.attr('href', getURL());
      };
      gotoURL = function() {
        window.location.href = getURL();
      };
      restrictKeyPress = function(event) {
        var keyValue;
        keyValue = String.fromCharCode(event.which);
        if (keyValue && /\D/.test(keyValue)) {
          event.preventDefault();
        }
      };
      restrictKeyUp = function(event) {
        var input, newValue;
        input = $(this);
        newValue = input.val().replace(/\D/g, '');
        if (newValue !== input.val()) {
          input.val(newValue);
        }
      };
      yearValue = function(input) {
        var string;
        string = input.val().replace(/\D/g, '');
        if (string === '') {
          return minYear;
        } else {
          return parseInt(string, 10);
        }
      };
      submitStart = function(event) {
        if (event.which === 13) {
          updateStart();
          return gotoURL();
        }
      };
      submitEnd = function(event) {
        if (event.which === 13) {
          updateEnd();
          return gotoURL();
        }
      };
      updateStart = function(event) {
        var endValue, startValue;
        startValue = yearValue($start);
        endValue = yearValue($end);
        if (startValue < minYear) {
          startValue = minYear;
        } else if (startValue > endValue) {
          startValue = endValue;
        }
        startValue = nearestYear(startValue, 'start');
        $start.val(startValue);
        return updateSlider();
      };
      updateEnd = function(event) {
        var endValue, startValue;
        startValue = yearValue($start);
        endValue = yearValue($end);
        if (endValue > maxYear) {
          endValue = maxYear;
        } else if (endValue < startValue) {
          endValue = startValue;
        }
        endValue = nearestYear(endValue, 'end');
        $end.val(endValue);
        return updateSlider();
      };
      nearestYear = function(year, rangeType) {
        var arrayIndex, index, value, _j, _len;
        year = parseInt(year, 10);
        index = allowedYears.indexOf(year);
        if (index === -1) {
          for (arrayIndex = _j = 0, _len = allowedYears.length; _j < _len; arrayIndex = ++_j) {
            value = allowedYears[arrayIndex];
            if (year < value) {
              if (rangeType === 'start' && arrayIndex > 0) {
                index = arrayIndex - 1;
              } else {
                index = arrayIndex;
              }
              break;
            }
          }
        }
        return allowedYears[index];
      };
      yearIndex = function(year) {
        var index;
        year = parseInt(year, 10);
        index = years.indexOf(year);
        if (index === -1) {
          addYear(year);
          index = years.indexOf(year);
        }
        return index;
      };
      sortNumber = function(a, b) {
        return a - b;
      };
      addYear = function(year) {
        years.push(parseInt(year, 10));
        years.sort(sortNumber);
        return $slider.slider("option", "max", years.length - 1);
      };
      updateSlider = function() {
        var endValue, startValue;
        updateURL();
        startValue = yearValue($start);
        endValue = yearValue($end);
        $slider.slider("values", 0, yearIndex(startValue));
        $slider.slider("values", 1, yearIndex(endValue));
        return window.changeTooltipsHeadeValues($slider, startValue, endValue);
      };
      addEventHandlers = function() {
        var $inputs;
        $inputs = $start.add($end);
        $inputs.attr('onblur', '').attr('onkeyup', '');
        $inputs.attr('pattern', '[0-9]*');
        $inputs.keypress(restrictKeyPress);
        $inputs.keyup(restrictKeyUp);
        $inputs.keyup(showLink);
        $inputs.change(updateURL);
        $start.blur(updateStart);
        $end.blur(updateEnd);
        $start.keypress(submitStart);
        $end.keypress(submitEnd);
        return $slider.on("slidestop", updateSlider);
      };
      ready = function() {
        removePreviousDates();
        hideLink();
        return addEventHandlers();
      };
      return $(document).ready(ready);
    }
  });

}).call(this);
