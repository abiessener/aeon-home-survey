myApp.controller('AdminReportingController', ['AdminService', '$mdDialog', '$timeout', '$mdSidenav', '$log', 'UserService', function (AdminService, $mdDialog, $timeout, $mdSidenav, $log, UserService) {


    //--------------------------------------
    //-------------VARIABLES----------------
    //--------------------------------------


    var self = this;

    self.AdminService = AdminService;
    self.UserService = UserService;

    // List of calculations we support for reporting
    self.calcList = [
        "Scores",
        "Gender",
        "How Long",
        "Ethnicity",
        "Age",
        "Income"
    ];

    self.calculation = self.calcList[0];

    self.yearToGet = thisYear;

    self.chartData = AdminService.chartData; // actual data is in .list property, which is an array of objects


    const START_YEAR = 2010;
    var thisYear = new Date();
    thisYear = thisYear.getFullYear();
    self.thisYear = thisYear;
    self.yearsArray = [];

    for (var i = thisYear; i >= START_YEAR; i--) {
        self.yearsArray.push(i);
    }

    self.yearToGet = thisYear;
    
    self.propertiesToGet = [];
    self.selectAllProperties = false;

    self.propertyList = AdminService.propertyList; // list of unique properties in .list

    const CANVAS_WIDTH = 450;
    const CANVAS_HEIGHT = 450;

    canvas = document.getElementById("myChart");
    context = document.getElementById("myChart").getContext("2d");
    context.canvas.width = CANVAS_WIDTH;
    context.canvas.height = CANVAS_HEIGHT;



    //--------------------------------------
    //-------------FUNCTIONS----------------
    //--------------------------------------

    // add property to list of properties to get from db
    self.addProperty = function (newProperty) {
        if (newProperty != undefined) {
            if (newProperty.length > 0) {
                // look for duplicate
                var index = self.propertiesToGet.indexOf(newProperty);

                if (index == -1) {
                    self.propertiesToGet.push(newProperty);
                    self.typedProperty = null;
                }
            }
        }
    }

    self.clearCalc = function () {
        self.yearToGet = null;
        self.propertiesToGet = [];
        self.selectAllProperties = false;
        self.calculation = null;
    }

    // remove property from list of properties to get from db
    self.deleteProperty = function (property) {
        var index = self.propertiesToGet.indexOf(property);
        self.propertiesToGet.splice(index, 1);
    }

    // download the current chart as a png
    self.downloadChart = function () {
        var datastream = canvas.toDataURL('image/png');
        /* Change MIME type to trick the browser to downlaod the file instead of displaying it */
        datastream = datastream.replace(/^data:image\/[^;]*/, 'data:application/octet-stream');

        /* In addition to <a>'s "download" attribute, we define HTTP-style headers */
        datastream = datastream.replace(/^data:application\/octet-stream/, 'data:application/octet-stream;headers=Content-Disposition%3A%20attachment%3B%20filename=Chart.png');

        var link = document.createElement("a");
        link.download = 'aeon-survey-custom-chart';
        link.href = datastream;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        delete link;
    };

    // Toggle Sidenav
    self.openLeftMenu = function () {
        $mdSidenav('left').toggle();
    };

    // takes a string based on user input, and gets the data and builds a chart based on that
    self.runCalc = function (calc) {

        if (self.selectAllProperties) {
            // "All" is one of the selected properties, which supercedes anything else
            self.propertiesToGet = AdminService.propertyList.list;
        }

        domElement = context; // where we're going to build the chart
        AdminService.getData(self.yearToGet, self.propertiesToGet, calc, domElement);

        context.canvas.width = CANVAS_WIDTH;
        context.canvas.height = CANVAS_HEIGHT;

        // reset properties array so if you un-toggle Select All after running a report you don't get all properties
        if(self.selectAllProperties){
            self.propertiesToGet = [];                    
        }
    
    }




    //--------------------------------------
    //-------------RUNTIME CODE-------------
    //--------------------------------------

    AdminService.getResponseRate(null, thisYear);
    self.responseRate = AdminService.responseRate;
    

}]);
