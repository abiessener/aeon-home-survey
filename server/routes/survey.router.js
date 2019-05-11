var express = require('express');
var router = express.Router();
var passport = require('passport');
var path = require('path');
var pool = require('../modules/pool.js');

const TEXT_QUESTIONS = [21, 22, 25, 28, 30];
const BOOLEAN_QUESTIONS = [30, 32, 33];
const SUPPORTED_LANGUAGES = [
    "english",
    "spanish",
    "somali",
    "hmong"
]
const ROLES = {
    RESIDENT: "Resident",
    ADMINISTRATOR: "Administrator",
    SITE_MANAGER: "Site Manager"
}

// DEBUG - generate random survey data

/*
function randomNumber(min, max) {
    return Math.floor(Math.random() * (1 + max - min) + min);
}

// var randomstring = require('randomstring'); // we don't use this lib any more

router.get('/data/:number', function (req, res) {
    console.log('GET /survey/data', req.params.number);

    if (req.params.number <= 10000 && req.params.number > 0) {

        const SURVEYS_TO_GENERATE = req.params.number;
        const SURVEY_YEAR = 2017;
        const NUM_BASIC_QUESTIONS = 20;
        const NUM_BASIC_ANSWERS = 4;
        const NUM_FREE_QUESTIONS = 2;
        const NUM_DEMO_QUESTIONS = 5;
        const DEMO_ANSWERS = [5, 7, 3, 6, 8]

        pool.connect(function (err, client, done) {
            if (err) {
                console.log('db connect error', err);
                res.sendStatus(500);
            } else {
                //get property names
                client.query('SELECT DISTINCT property FROM occupancy WHERE year=2017 ORDER BY property;', function (err, occupancyData) {
                    done();
                    if (err) {
                        console.log('query error', err);
                        res.sendStatus(500);
                    } else {
                        var properties = [];
                        for (var i = 0; i < occupancyData.rows.length; i++) {
                            properties.push(occupancyData.rows[i].property);
                        }

                        var languages = ['english', 'spanish', 'hmong', 'somali'];

                        // now we have our property names, we can use them to help us generate random survey data
                        var queryString = "INSERT INTO responses (property, language, year, answer1, answer2, answer3, answer4, answer5, answer6, answer7, answer8, answer9, answer10, answer11, answer12, answer13, answer14, answer15, answer16, answer17, answer18, answer19, answer20, answer21, answer22, answer23, answer24, answer25, answer26, answer27) VALUES "
                        for (var i = 0; i < SURVEYS_TO_GENERATE; i++) {
                            var survey = [];
                            var index = randomNumber(0, properties.length - 1);
                            if (properties[index] == undefined) {
                                console.log('propindex', index);
                            }
                            survey.push("'" + properties[index] + "'");
                            index = randomNumber(0, languages.length - 1);
                            if (languages[index] == undefined) {
                                console.log('langindex', index);
                            }

                            survey.push("'" + languages[index] + "'");

                            survey.push(SURVEY_YEAR);

                            for (var j = 0; j < NUM_BASIC_QUESTIONS; j++) {
                                index = randomNumber(0, NUM_BASIC_ANSWERS);
                                if (index > 0) {
                                    if (j < 21 && index == 3){
                                        index = 4;
                                    }

                                    if (j < 13 && index == 2){
                                        index = 3;
                                    }

                                    if (j < 5 && index == 1){
                                        index = 2;
                                    }

                                    if (j <= 18 && j >= 13 && index == 1){
                                        index = 4;
                                    }

                                    if (j == 21 && index < 3){
                                        index = 3;
                                    }

                                    survey.push(index);
                                } else {
                                    survey.push(null);
                                }
                            }
                            for (var j = 0; j < NUM_FREE_QUESTIONS; j++) {
                                if (randomNumber(0, 1) > 0) {
                                    survey.push("'" + 'fjdalk' + "'");
                                } else {
                                    survey.push(null);
                                }
                            }
                            for (var j = 0; j < NUM_DEMO_QUESTIONS; j++) {
                                index = randomNumber(0, DEMO_ANSWERS[j]*10);
                                if (index > 0) {
                                    if(index == 2){
                                        if (randomNumber(0,2) == 0){
                                            index == 1;
                                        }
                                    } else if (index == 4){}
                                    survey.push(index);
                                } else {
                                    survey.push(null);
                                }
                            }

                            // survey[] is now one randomized survey's worth of data, let's add it to the queryString

                            // queryString = ...'VALUES ' --OR-- ...'5,3,2,1),'
                            queryString += "(";

                            for (var j = 0; j < survey.length; j++) {
                                var data = survey[j];
                                queryString += data + ","; // "(chicago,"
                            } // "...5,3,2,1,"

                            queryString = queryString.slice(0, -1) + "),"; // "(...5,3,2,1),"

                        } // end big for loop

                        // now we have a ton of surveys pushed into queryString, and the end of it looks like:
                        // queryString =  ...'5,3,2,1),'
                        queryString = queryString.slice(0, -1) + ';';
                        // queryString is built! now to INSERT it into responses2017

                        pool.connect(function (err, client, done) {
                            if (err) {
                                console.log('debug insert connect error', err);
                                res.sendStatus(500);
                            } else {
                                client.query(queryString, function (err, data) {
                                    if (err) {
                                        console.log('debug insert query error', err);
                                        res.sendStatus(500);
                                    } else {
                                        res.sendStatus(201);
                                    }
                                });
                            }
                        });
                    }
                });
            }
        });
    } else {
        //bad number param
        res.status(400).send('bad year param');
    }
});
*/

router.get('/begin', function (req, res) {
    if (req.isAuthenticated()) {
        if (req.user.role == 'Resident') {
            // is this property/unit combo legit?
            pool.connect(function (err, client, done) {
                if (err) {
                    console.log('db connect error', err);
                    res.sendStatus(500);
                } else {
                    client.query('SELECT * FROM occupancy WHERE property=$1 AND unit=$2 AND year=$3', [req.query.property, req.query.unit, req.query.year], function (err, data) {
                        done();
                        if (err) {
                            console.log('query error', err);
                            res.sendStatus(500);
                        } else {
                            if (data.rows[0]) {
                                if (data.rows[0].responded) {
                                    // responded == true
                                    res.send('responded');
                                } else {
                                    res.send('authorized');
                                }
                            } else {
                                // unit not found
                                res.send('unit not found');
                            }
                        }
                    });
                }
            });
        } else {
            //not resident role
            res.sendStatus(403);
        }
    } else {
        // not authenticated
        res.sendStatus(403);
    }

});

router.get('/household', (req, res) => {
    const householdSql = "SELECT household FROM properties WHERE name=$1 LIMIT 1;";
    console.log(req.query.property);

    let household = false;

    if (req.isAuthenticated()) {
        pool.connect(function (err, client, done) {
            if (err) {
                console.log('error connecting to db', err);
                res.sendStatus(500);
            } else {
                client.query(householdSql, [req.query.property], function (err, data) {
                    done();
                    if (err) {
                        console.log('query error household', err);
                        res.sendStatus(500);
                    } else {
                        console.log('household query: ' + data.rows[0].household)
                        if (data.rows[0].household === true) {
                            household = true;
                        }
                        res.send(household);
                    }
                });
            }
        });
    } else {
        res.sendStatus(403)
    }
});

router.get('/language', function (req, res) {
    if (!validateSurveyLanguage(req.query.language)) {
        res.sendStatus(400)
        return
    }

    if (!validateAuthorization(req, ROLES.RESIDENT)) {
        res.sendStatus(403)
        return
    }

    const languageSql = `SELECT question_number, ${req.query.language} FROM questions;`;
    const translationSql = `SELECT type, ${req.query.language} FROM translations;`;

    const surveyObject = {};

    pool.connect(function (err, client, done) {
        if (err) {
            console.log('error connecting to db', err);
            res.sendStatus(500);
            return
        }
        
        client.query(languageSql, function (err, data) {
            if (err) {
                done();
                console.log('query error language', err);
                res.sendStatus(500)
                return
            }

            surveyObject.questions = data.rows;
        })

        client.query(translationSql, function (err, data) {
            if (err) {
                done();
                console.log('query error translation', err);
                res.sendStatus(500)
                return
            }
            done();

            surveyObject.translations = data.rows;
            res.send(surveyObject);
        })
    });
});

// fetches list of questions out of the db. 'year' param defaults to this year if not specified, which it generally shouldn't be
router.get('/questions/:year?', function (req, res) {
    if (req.isAuthenticated()) {
        if (req.user.role == 'Administrator') {
            var thisYear = new Date();
            thisYear = thisYear.getFullYear();
            var year = req.params.year || thisYear;

            pool.connect(function (err, client, done) {
                if (err) {
                    console.log('db connection error', err);
                    res.sendStatus(500);
                } else {
                    client.query('SELECT * FROM questions ORDER BY question_number', function (err, data) {
                        done();
                        if (err) {
                            console.log('db query error', err);
                            res.sendStatus(500);
                        } else {
                            res.send(data.rows);
                        }
                    });
                }
            });
        } else {
            //not resident role
            res.sendStatus(403);
        }
    } else {
        // not authenticated
        res.sendStatus(403);
    }
});

// updates the posted question in the db. 'year' defaults to this year if not specified, which it really shouldn't be.
router.post('/questions/:year?', function (req, res) {
    if (req.isAuthenticated()) {
        if (req.user.role == 'Administrator') {
            var thisYear = new Date();
            thisYear = thisYear.getFullYear();
            var year = req.params.year || thisYear;

            var questionToAdd = {
                id: req.body.id,
                english: req.body.english,
                somali: req.body.somali,
                spanish: req.body.spanish,
                hmong: req.body.hmong,
                theme: req.body.theme,
                // year: year,
            }

            var queryString = "UPDATE questions SET english=$1, somali=$2, spanish=$3, hmong=$4, theme=$5 WHERE id=$6;";

            pool.connect(function (err, client, done) {
                if (err) {
                    console.log('db connection error', err);
                    res.sendStatus(500);
                } else {
                    client.query(queryString, [questionToAdd.english, questionToAdd.somali, questionToAdd.spanish, questionToAdd.hmong, questionToAdd.theme, questionToAdd.id], function (err, data) {
                        done();
                        if (err) {
                            console.log('db query error', err);
                            res.sendStatus(500);
                        } else {
                            res.sendStatus(200);
                        }
                    });
                }
            });
        } else {
            //not resident role
            res.sendStatus(403);
        }
    } else {
        // not authenticated
        res.sendStatus(403);
    }
});

// takes a completed survey and posts it to the database. also updates the unit to having responded in the `occupancy` table.
router.post('/', function (req, res) {
    if (req.isAuthenticated()) {
        if (req.user.role == 'Resident') {
            var thisYear = new Date();
            thisYear = thisYear.getFullYear();
            var sanitizedAnswers = sanitizeSurveyResponse(req.body.list);
            var sqlValues = [req.query.property, req.query.language, thisYear].concat(sanitizedAnswers).concat([req.body.household]);

            queryString = "INSERT INTO responses (property, language, year, answer1, answer2, answer3, answer4, answer5, answer6, answer7, answer8, answer9, answer10, answer11, answer12, answer13, answer14, answer15, answer16, answer17, answer18, answer19, answer20, answer21, answer22, answer23, answer24, answer25, answer26, answer27, answer28, answer29, answer30, answer31, answer32, answer33, household) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37);";

            pool.connect(function (err, client, done) {
                if (err) {
                    console.log('error connecting to db', err);
                    res.sendStatus(500);
                } else
                    // double-check that the unit hasn't responded yet 
                    client.query('SELECT * FROM occupancy WHERE property=$1 AND unit=$2 AND year=$3', [req.query.property, req.query.unit, req.query.year], function (err, data) {
                        if (err) {
                            done();
                            console.log('unit check query error', err);
                            res.sendStatus(500);
                        } else {
                            if (data.rows[0]) {
                                // unit is found
                                if (data.rows[0].responded) {
                                    done();
                                    res.send('responded');
                                } else {
                                    // unit exists and hasn't responded. first, enter the survey data
                                    client.query(queryString, sqlValues, function (err, data) {
                                        if (err) {
                                            done();
                                            console.log('insert query error', err, queryString);
                                            res.sendStatus(500);
                                        } else {
                                            client.query('UPDATE occupancy SET responded=true WHERE property=$1 AND unit=$2;', [req.query.property, req.query.unit], function (err, data) {
                                                done();
                                                if (err) {
                                                    console.log('query error', err);
                                                    res.sendStatus(500);
                                                } else {
                                                    res.sendStatus(201);
                                                }
                                            });
                                        }
                                    });

                                }
                            } else {
                                // unit not found
                                done();
                                res.send('unit not found');
                            }
                        }
                    });
            });
        } else {
            //not resident role
            res.sendStatus(403);
        }
    } else {
        // not authenticated
        res.sendStatus(403);
    }
});

function sanitizeSurveyResponse(surveyAnswers) {
    return surveyAnswers.map(value => value.answer ? value.answer : null);
}

function validateSurveyLanguage(language) {
    return SUPPORTED_LANGUAGES.includes(language)
}

function validateAuthorization(req, role) {
    return req.isAuthenticated() && req.user.role == role
}

module.exports = router;