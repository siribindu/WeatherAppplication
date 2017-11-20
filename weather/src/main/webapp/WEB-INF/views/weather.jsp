<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html ng-app="pacteraWeather">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
	
	<title>Current Weather</title>
</head>
<body >

<div class="container">
	<h2>Current Weather</h2>
<div class="well" ng-controller="WeatherController">
  
	<p>
	Please select a state to display current weather details
    </p>
    <p>
	<select id="citySelector" ng-model="selectedCity" ng-options="city for city in cities.citiesList" onchange="loadWeather()">
    	<option value="">Select City</option>
	</select>
    </p>
  </div>
</div>
<div id="weatherResponse" class="table-responsive">
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="http://momentjs.com/downloads/moment.js"></script>

 <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
  
<script>
	angular.module('pacteraWeather', []).controller('WeatherController', function ($scope, $http) {
    $scope.cities = [];
	$scope.selectedCity = null;
    $http({
            method: 'GET',
            url: '/pactera/CityAll',
        }).success(function (result) {
        $scope.cities = result;
        console.log($scope.cities);
    });
});
</script>
<script>
function loadWeather() {
	  var xhttp = new XMLHttpRequest();
	  var weather;
	  var weather_response;
	  xhttp.onreadystatechange=function() {
	    if (xhttp.readyState == 4 && xhttp.status == 200) {	      
	      weather = xhttp.responseText;
		  weather_response = JSON.parse(weather);
		  console.log(weather_response);
		  generateTable(weather_response);
	    }
	  };
	  xhttp.open("GET", "CityWeather/" + $("#citySelector :selected").text(), true);
	  xhttp.send();
	  
}

function generateTable(response) {

	var tableData;
	tableData = "<table class='table table-bordered'><thead class='thead-inverse'><tr><th>Type</th><th>Information</th></tr></thead>";
	tableData += "<tbody><tr><td>City</td><td>" + response.name + "</td>";
	tableData += "<tbody><tr><td>Updated time</td><td>" +  moment(new Date(response.dt*1000)).format('MMMM Do YYYY, h:mm a') + "</td>";
	tableData += "<tbody><tr><td>Weather</td><td>" + response.weather[0].description + "</td>";
	tableData += "<tbody><tr><td>Temperature</td><td>" + (response.main.temp - 273.15).toFixed(2) + " degrees C </td>";
	tableData += "<tbody><tr><td>Wind</td><td>" + response.wind.speed + " km/h</td>";
	
	tableData += "</tbody></table>";
	document.getElementById('weatherResponse').innerHTML = tableData;
}
</script>
</body>
</html>
