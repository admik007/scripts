#!/bin/bash
for i in `ls | grep rrd | sed 's/.rrd//g'`; do
echo ${i}
echo "
<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
 <title> General info </title>
 <meta http-equiv=\"Expires\" CONTENT=\"Sun, 12 May 2003 00:36:05 GMT\">
 <meta http-equiv=\"Pragma\" CONTENT=\"no-cache\">
 <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
 <meta http-equiv=\"Cache-control\" content=\"no-cache\">
 <meta http-equiv=\"Content-Language\" content=\"sk\">
 <meta http-equiv=\"refresh\" content=\"35\">
 <meta name=\"GOOGLEBOT\" CONTENT=\"noodp\">
 <meta name=\"pagerank\" content=\"10\">
 <meta name=\"msnbot\" content=\"robots-terms\">
 <meta name=\"revisit-after\" content=\"2 days\">
 <meta name=\"robots\" CONTENT=\"index, follow\">
 <meta name=\"alexa\" content=\"100\">
 <meta name=\"distribution\" content=\"Global\">
 <meta name=\"keywords\" lang=\"sk\" content=\"date, time, ip, browswer, operating system\">
 <meta name=\"description\" content=\"Webpage for general info\">
 <meta name=\"Author\" content=\"Author\">
 <meta name=\"copyright\" content=\"(c) 2016 Company\">
</head>
<body>
<table align=\"center\">
 <tr>
  <td>
   <img src=\"${i}-day.png\" alt=\"${i}-day.png\">
  </td>
 </tr>
 <tr>
  <td>
   <img src=\"${i}-week.png\" alt=\"${i}-week.png\">
  </td>
 </tr>
 <tr>
  <td>
   <img src=\"${i}-month.png\" alt=\"${i}-month.png\">
  </td>
 </tr>
 <tr>
  <td>
   <img src=\"${i}-year.png\" alt=\"${i}-year.png\">
  </td>
 </tr>
</table>
<p align=\"center\"><a href=\"http://validator.w3.org/check?uri=referer\" target=\"_blank\"><img src=\"http://www.w3.org/Icons/valid-html401\" alt=\"Valid HTML 4.01 Transitional\" height=\"31\" width=\"88\" border=\"0\"></a>
</body>
</html>
" > /var/www/mrtg/${i}.html

done
