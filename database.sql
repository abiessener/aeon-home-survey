CREATE TABLE volunteer_gift_cards
(
    id SERIAL PRIMARY KEY,
    year INT,
    property TEXT,
    unit TEXT,
    paid BOOLEAN,
    name TEXT,
    addressOne TEXT,
    addressTwo TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    type TEXT
)
CREATE TABLE survey_status
(
    id SERIAL PRIMARY KEY,
    year INT,
    open_residents BOOLEAN,
    open_volunteers BOOLEAN
);
CREATE TABLE lab_usage
(
    id SERIAL PRIMARY KEY,
    language TEXT,
    property TEXT,
    timestamp BIGINT,
    age TEXT,
    reason TEXT
);
CREATE TABLE resident_emails
(
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL,
    year INT NOT NULL,
    reference_id TEXT,
    paid BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT FALSE
);
CREATE UNIQUE INDEX email_year on resident_emails (email, year);
CREATE INDEX ON resident_emails ((lower(email)));
CREATE TABLE questions
(
    id SERIAL PRIMARY KEY,
    question_number INT,
    english TEXT NOT NULL,
    somali TEXT NOT NULL,
    spanish TEXT NOT NULL,
    hmong TEXT NOT NULL,
    oromo TEXT NOT NULL,    
    theme TEXT,
    year INT
);
CREATE TABLE translations
(
    id SERIAL PRIMARY KEY,
    type TEXT NOT NULL UNIQUE,
    english TEXT NOT NULL,
    somali TEXT NOT NULL,
    spanish TEXT NOT NULL,
    hmong TEXT NOT NULL,
    oromo TEXT NOT NULL
);
CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role TEXT,
    token TEXT,
    active BOOLEAN DEFAULT FALSE,
    timestamp TEXT
);
CREATE TABLE occupancy
(
    id SERIAL PRIMARY KEY,
    property TEXT NOT NULL,
    unit TEXT NOT NULL,
    responded BOOLEAN,
    paper_response BOOLEAN,
    paid BOOLEAN,
    occupied BOOLEAN,
    year INT NOT NULL
);
CREATE TABLE properties
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    household BOOLEAN
);
CREATE TABLE responses
(
    id SERIAL PRIMARY KEY,
    property TEXT NOT NULL,
    language TEXT NOT NULL,
    year INT NOT NULL,
    answer1 INT,
    answer2 INT,
    answer3 INT,
    answer4 INT,
    answer5 INT,
    answer6 INT,
    answer7 INT,
    answer8 INT,
    answer9 INT,
    answer10 INT,
    answer11 INT,
    answer12 INT,
    answer13 INT,
    answer14 INT,
    answer15 INT,
    answer16 INT,
    answer17 INT,
    answer18 INT,
    answer19 INT,
    answer20 INT,
    answer21 TEXT,
    answer22 TEXT,
    answer23 INT,
    answer24 INT,
    answer25 TEXT,
    answer26 INT,
    answer27 INT,
    answer28 TEXT,
    answer29 INT,
    answer30 BOOLEAN,
    answer31 TEXT,
    answer32 TEXT,
    answer33 BOOLEAN,
    answer34 TEXT
);

CREATE TABLE occupancy_users
(
    occupancy_property TEXT NOT NULL,
    user_id INT REFERENCES users,
    PRIMARY KEY(occupancy_property, user_id)
);

CREATE TABLE household
(
    id SERIAL PRIMARY KEY,
    property TEXT NOT NULL,
    unit TEXT NOT NULL,
    year INT,
    name TEXT,
    date_of_birth DATE,
    gender TEXT,
    race_white BOOLEAN,
    race_black BOOLEAN,
    race_islander BOOLEAN,
    race_native BOOLEAN,
    race_asian BOOLEAN,
    race_self_identify TEXT,
    hispanic_or_latino BOOLEAN,
    disabled BOOLEAN
);


INSERT INTO translations (type, english, spanish, somali, hmong, oromo) VALUES
('directions1', 'For each question, touch the button that best describes your experience during the last 12 months. Touch NEXT to go to the next page. Touch GO BACK to go back a page. Press CANCEL to cancel the survey', 'En cada pregunta, pulse el botón que describe mejor su experiencia en los últimos 12 meses. Presione AVANZAR para pasar a la siguiente página. Presione RETROCEDER para devolverse a la página anterior. Presione CANCELAR para cancelar la encuesta.', 'Su’aal kasta, taabo batoonka jawaabta kuugu fiican wixii aad la kulantay 12-kii bilood ee ugu dambeeyey. Taabo NEXT si aad bog kale ugu gudubto. Taabo GO BACK si aad dib ugu noqoto. Taabo CANCEL si aad isaga joojiso su’aalaha.', 'Rau ib lo lus nug, nias lub npov uas piav qhia qhov koj tau ntsib zoo dua tshaj rau lub sijhawm 12 lub hlis tag los. Kov TOM NTEJ NTXIV MUS yog xav mus rau nplooj ntawv tom ntej. Kov ROV MUS TOM QAB yog xav rov mus rau nplooj ntawm tom qab. Nias MUAB TSO TSEG yog xav muab daim ntawv xam phaj tso tseg.', 'Gaaffilee gaditti eeramaniif ji''oota 12 n darban keessatti mudannoo/muuxannoo keessan kan agarsiisu xuqaa. Fuula itti aanutti darbuuf isa ''Next'' jedhu xuqaa. Yoo qu''annoo kana dhiisuu barbaaddan ammo is ''CANCEL'' jedhu xuqaa'),
('directions2', 'Please enter your answers to each question in the box.', 'Por favor ingrese sus respuestas de cada pregunta en el recuadro.', 'Fadlan santuuqa dhex ku qor jawaabaha su’aal kasta.', 'Thov tso koj cov lus teb rau txhua lo lus nug nyob rau hauv lub npov.', 'Maaloo deebii keessan gaaffilee tokkoo tokkoof saanduqa keessatti deebisa''a.'),
('begin', 'Begin Survey', 'Comenzar encuesta', 'Bilow Su’aalaha', 'Pib Cov Lus Xam Phaj', 'Qu''annoo jalqabii'),
('property', 'Property', 'Propiedad', 'Guri', 'Vaj Tse', 'Mana/Qabeenya'),
('unit', 'Unit Number', 'Número de apartamento', 'Lambarka Guriga', 'Chav Tsev', 'lakkoobsaa Kutaa'),
('progress', 'Survey Progress', 'Progreso de la encuesta', 'Su’aalahaad ka Jawaabtay', 'Kev Xam Phaj Txog Twg Lawm', 'Adeemsa Qu''annoo'),
('continue', 'Continue', 'Continuar', 'Sii-wad', 'Ua Ntxiv Mus', 'Itti fufi'),
('instructions', 'Instructions', 'Instrucciones', 'Tilmaamo', 'Cov Lus Taw Qhia', 'Qajeelfama'),
('next', 'Next', 'Avanzar', 'Sii-soco', 'Mus Tom Ntej', 'Isa itti haanu'),
('goback', 'Go Back', 'Retroceder', 'Dib u Noqo', 'Rov Mus Tom Qab', 'Boodatti deebi''aa'),
('cancel', 'Cancel', 'Cancelar', 'Tirtir', 'Tso Tseg', 'Haqa''a'),
('review', 'Review Your Answers', 'Revisar sus respuestas', 'Eeg Jawaabahaaga', 'Rov Saib Xyuas Dua Koj Cov Lus Teb', 'Deebii keessan keessa deebi''aa ilaala''a'),
('touchToGoBack', 'Touch any question to go back and change your answer.', 'Pulse cualquier pregunta para retroceder y cambiar su respuesta', 'Taabo su’aal kasta si aad dib ugu noqoto oo aad u beddesho jawaabtaada.', 'Nias lo lus nug twg los tau yog koj xav mus rau tom qab thiab hloov koj lo lus teb', 'Deebii keessan jijjiiruuf gaaffii feetan yoo xuqxan boodatti isin deebisa.'),
('submit', 'Submit', 'Completar y enviar encuesta', 'Dir', 'Muab Xa Mus', 'Galchi'),
('submitdesc', 'Pressing the Submit button will submit your answers to Aeon and enter you into a drawing for gift cards and one month of free rent. After doing so, please hand this tablet back to the Aeon site manager to receive $10.', 'Sus respuestas serán enviadas al presionar el botón de Enviar. Usted estará participando en una rifa de una tarjeta de regalo y de un mes de alquiler gratis. Después de presionar el botón de Enviar lleve este document al administrador de su edificio y obtendrá $10. ¡Gracias!','Guji batoonka ‘Submit’ si aad u dirto jawaabahaaga. Markaas waxaa lagugu dari doonaa abaalmarin bakhtiyaa-nasiib ah oo aad ku heli karto kaar hadyad ah iyo hal bil oo kiro bilaash ah. Markaad dirto ee aad gujiso ‘Submit’, warqadda u dhiib maamulaha guriga aad ku nooshahay si laguu siiyo 10 doollar oo ah hadyad. Mahadsanid!', 'Nias lub npov Xa Mus yuab muab koj cov lus teb xa mus. Thiab lawv yuav muab koj tso npe cuv xab laj saib puas tau ib daim npav phaj tshab thiab tau nyob pub dawb tsis them nqi tsev ib lub hlis. Tom qab nias Xa Mus, muab qhov no cev rov rau koj tus nai saib vaj tse ces koj tau txais $10. Ua tsaug!', 'Mallattoo isa ''Submit'' jedhu yoo xuqxan deebiin keessan Aeoroniif galii ta''a akkasumas carraa $10 argachuuf akkasumas carraa kiraa manaa kan ji''a tokkoo bilaasha akka argachuuf dorgomtan isin galmeessa.'),
('howlong1', '1 to 3 months', '1 a 3 meses', '1 illaa 3 bilood', '1 txog 3 hlis','Ji’oota 1-3'),
('howlong2', '4 to 11 months', '4 a 11 meses', '4 illaa 11 bilood', '4 txog 11 hlis','Ji’oota 4-11'),
('howlong3', '1 to 3 years', '1 a 3 años', '1 illaa 3 sano', '1 txog 3 xyoos','Waggoota 1-3'),
('howlong4', '3 to 5 years', '3 a 5 años', '3 illaa 5 sano', '3 txog 5 xyoos','Waggoota 3-5'),
('howlong5', '5+ years', '5+ años', '5+ Sano', '5 xyoos rov sauv','Waggoota 5 caa laa'),
('ethnicity1', 'American Indian', 'American Indian', 'Hindi Maraykan', 'Neeg Khab', 'American Indian'),
('ethnicity2', 'African Immigrant (Somali, Nigerian, Eritrean, other)', 'Inmigrante de Africa (Somali, Nigerian, Eritrean, otro)', 'Immigrant Afrika (Soomaaliya, Nigeria, Eritrean, kale)', 'Neeg Dub (Tuaj lwm teb chaws tuaj, xws li Xas Mas Lias)', 'Godantota Afrika (Somalii, Nigria, Eritrea, Kanbira)'),
('ethnicity3', 'Asian / Pacific Islander', 'Asian / Pacific Islander', 'Aasiyaan / Jasiidlay Baasifik ', 'Neeg Es Xias', 'Asia/Pacific'),
('ethnicity4', 'Black / African American', 'Negro / African American', 'Madow / Afrikaan Ameerikaan', 'Kheej Dub', 'Afrikan/American'),
('ethnicity5', 'Caucasian / White', 'Anglo / Blanco', 'Kookeeshiyaan / Caddaan', 'Neeg Dawb', 'Caucasian/Adii'),
('ethnicity6', 'Hispanic / Latino', 'Hispanic / Latino', 'Hisbaanik / Laatino', 'Neeg Mev', 'Hispanic/Latino'),
('ethnicity7', 'Other', 'Otro', 'Kuwo kale', 'Lwm Yam', 'Kan Bira'),
('gender1', 'Female', 'Mujer', 'Dheddig', 'Poj niam', 'Dhira'),
('gender2', 'Male', 'Hombre', 'Lab', 'txiv neej', 'Dubra'),
('gender3', 'Self Identify', 'Autoproclamarse', 'Isku aqoonsi', 'Koj xaiv (lwm yam)', 'Of-hima/ibsaa:'),
('age1', 'Under 18', 'Bajo 18', 'Ka yar 18', 'Qis dua 18', 'Waggaa 18 gadi'),
('age2', '18-25', '18-25', '18-25', '18-25', '18-25'),
('age3', '26-35', '26-35', '26-35', '26-35', '26-35'),
('age4', '36-45', '36-45', '36-45', '36-45', '36-45'),
('age5', '46-55', '46-55', '46-55', '46-55', '46-55'),
('age6', 'Over 55', 'Más de 55', 'Ka wayn 55', 'tshaj 55', '55 oli'),
('income1', 'Less than $800/mo. (Less than $9,600/yr.)', 'Bajo de $800/mes. (Bajo de $9,600/año.)', 'In ka yar $800/bish. (In ka yar $9,600/san.)', 'Ib hlis tsawg dua $800 (ib xyoos tsawg dua $9,600)', 'Ji’atti $800 gadi ykn waggaatti
$9,600 gadi'),
('income2', '$801- 1,300/mo. ($9601 - 15,600/yr.)', '$801-1,300/mes. ($9601 - 15,600/año.)', '$801-1,300/bish. ($9601 - 15,600/san.)', 'Ib hlis $801 - $1,300 (ib xyoos $$9,601 - $15,600)', 'Ji’atti $801-1,300 gadi ykn wag- gaatti $9601- 15,600 gadi'),
('income3', '$1,301-1,800/mo. ($15,601 -21,600/yr.)', '$1,301-1,800/mes. ($15,601 - 21,600/año.)', '$1,301-1,800/bish. ($15,601 - 21,600/san.', 'Ib hlis $1,301 - $1,800 (ib xyoos $15,601 - $$21,600)', 'Ji’atti $1,301- 1800 ykn wag- gaatti $15,601- 21,600'),
('income4', '$1,801-2,300/mo. ($21,601-27,600/yr.)', '$1,801-2,300/mes. ($21,601- 27,600/año.)', '$1,801-2,300/bish. ($21,601- 27,600/san.)', 'Ib hlis $1,801 - $2,300 (ib xyoos $21,601 - $27,600)', 'Ji’atti $1801- 2,300 ykn waggaatti $ 21,601-27.600'),
('income5', '$2,301-2,800/mo. ($27,601-33,600/yr.)', '$2,301-2,800/mes. ($27,601-33,600/año.)', '$2,301-2,800/bish. ($27,601-33,600/san.)', 'Ib hlis $2,301 - $2,800 (ib xyoos $27,601 - $33,600)', 'Ji’atti $2,301- 2,800 ykn wag- gaatti $27,601- 33.600'),
('income6', '$2,801-3,300/mo. ($33,601-39,600/yr.)', '$2,801-3,300/mes. ($33,601- 39,600/año.)', '$2,801-3,300/bish. ($33,601- 39,600/san.)', 'Ib hlis $2,801 - $3,300 (ib xyoos $33,601 - $39,600)', 'Ji’atti $ 2,801-3,300 ykn wag- gaatti $33,601- 39,600'),
('income7', '$3,301-3,800/mo. ($39,601-45,600/yr.)', '$3,301-3,800/mes. ($39,601- 45,600/año.)', '$3,301-3,800/bish. ($39,601- 45,600/san.)', 'Ib hlis $3,301 - $3,800 (ib xyoos $39,601 - $45,600)', 'Ji’atti 3,301-3,800 ykn wag- gaatti $39,601- 45,600'),
('income8', 'More than $3,800/mo. (More than 45,600/yr.)', 'Más de $3,800/mes. (Má de 45,600/año.)', 'In ka badan $ 3,800/mo. (In ka badan 45,600/san.)', 'Ib hlis ntau dua $3,800 (ib xyoos ntau dua $45,600)', 'Ji’atti $3,800 caalaa ykn wag- gaatti $45,600 caalaa'),
('thanks', 'Thank you!  Please confirm your email address to receive your $10 gift card for completing the 2020 Home Score Survey.', '¡Gracias! Por favor,  confirme su correo electrónico para que reciba una tarjeta de regalo de $10 por completar la Encuesta de Evaluación de Vivienda del 2020.', 'Mahadsanid!  Fadlan xaqiiji cinwaankaaga boostada intarnetka (email) si aad u hesho kaar hadyad ah ama $10 gift card oo la isku siiyo markaad ka jawaabto daraasadda dadka deggan guryaha ee 2020 Home Score Survey.', 'Ua tsaug ntau!  Thov lees paub hais koj li chaw nyob email txhawm rau thiaj li tau txais koj daim npav khoom plig $10 rau kev ua tiav qhov Kev Tshuaj Ntsuam Xyuas Txog Tus Lej Vaj Tsev Xyoo 2020.', 'Galatoomaa! Q''annoo Home Score Survey 2020 guutuu keessaniif akka kaardii kennaa (gift card $10) argattaniif maaloo e-mail keessan nuu mirkaneessaa.'),
('requestresults', 'Summarized results of this confidential survey will be available in November.', 'El resumen de los resultados de esta encuesta confidencial estará disponible en noviembre.', 'Jawaabaha qof kasta iyadoon la kala garan karin ayaa natiijooyinka daraasadda oo la soo koobay la soo gudbin doonaa bisha Nofeembar.', 'Qhov kawg uas suav sau ntsiab lus los ntawm qhov kev tshuaj ntsuam xyuas uas tsis pub tham tawm rau leej paub txog no yuav muaj nyob rau Lub Kaum Ib Hlis Ntuj.', 'Cuunfaan bu''aa qu''annoo kanaa kan iccitiin qabamu ji''a Sadaasaa keessa ni beekama.'),
('optional', '(Questions 23-27 are optional)', '(Preguntas 23-27 son opcionales)', '(Su''aalaha 23-27 ayaa ikhtiyaar ah)', '(Cov Lus Nug Nqe 23 - 27 no teb los tau hos tsis teb los tsis ua cas)', '(Gaafiilee 23-27 yoo barbaaddan qofa deebiftu)'),
('intro1_1', 
'Thank you for taking this survey to tell Aeon what it’s like to live in your home.',
'Gracias por tomar esta encuesta para contar a Aeon cómo es vivir en su casa.',
'Waad ku mahadsan tahay in aad ka jawaabto su’aalo qoran oo aad Aeon fikrad uga siineyso nolosha guriga aad deggen tahay.',
'Ua tsaug uas koj tseem teb cov lus qhia rau Aeon hais tias koj nyob hauv lub tsev no nws ho zoo li cas rau li cas.',
'Qorannoo kana keessatti hirmaachuun, halli mana keessanii maal akka fakkaatu Aeoniif ibsuu keessaniif galatoomaa.'),
('intro1_2', 
'All answers are private and will be combined with everyone else’s answers, so we will not know how you answered each question.',
'Todas las respuestas son privadas y las combinarán con las respuestas de los demás. Por lo tanto, no sabremos cómo usted haya contestado cada pregunta.',
'Jawaabaha dadka oo dhan waa kuwa qarsoodi ah oo waa la isu-geyn doonaa, lama ogaan karo sida aad adigu wax uga jawaabtay.',
'Koj cov lus teb yuav tsis muab qhia rau leej twg paub li, thiab peb yuav muab xyaw rau lwm leej lwm tus cov lus teb, uas yuav tsis muaj neeg paub hais tias leej twg yog tus teb li cas.',
'Deebiin keessan hundi kan namoota biraa wajjin waan makamuuf, namni deebii keessaan beekuhin jiru.'),
('intro1_3',
'You can skip questions or stop the survey at any time. When answering, please think about the past 12 months.',
'Puede brincar preguntas o detener la encuesta en cualquier momento.  Cuando contesta, favor de pensar con respeto a los últimos 12 meses.',
'Haddii aad rabto su’aalaha kama jawaabeysid ama markii aad rabto ayaad iska joojin kartaa. Marka aad su’aalaha ka jawaabeyso fadlan ka feker 12-kii bilood ee ugu dambeeyey.',
'Koj teb teb txog tog koj txawm xav tsum los yeej tsum tau li nawb. Thaum koj teb cov lus, koj teb raws li 12 lub hlis dhau los no xwb.',
'Gaaffi takka-takka bira durbuu yoo feetan in dandeessu ykn qorannichayyuu dhaabuu in dandeessu. Yeroo gaaffii deebiftan, haala ji’oota 12 darban keessa dabartan xiinxalaa.'),
('intro2', 'If you have any questions, please talk to your Site Manager or Resident Connections Coordinator. Surveys are available in English, Hmong, Somali, Oromo, and Spanish. Other languages can be made available, please ask your Site Manager.', 'Si tiene alguna duda, favor de hablar con su gerente de sitio o un coordinador de Conexiones de Residente.  Las encuestas están disponibles en inglés, hmong, somalí y español. Se puede hacer disponibles otros idiomas.  Favor de preguntar a su gerente de sitio.', 'Haddii aad su’aalo ka qabto arrintan, fadlan kala hadal Maamulaha Guriga ama Isku-duwaha Xiriirka Kireystaha. Su’aaluhu waxa ay ku qoran yihiin afafka kala ah Ingiriis, Soomaali, Moong iyo Isbaanish. Luuqad kale qofkii raba waa loogu soo diyaarin karaa, fadlan kala xiriir Maamulaha Guriga.', 'Yog koj muaj lus nug dab tsi no ces nug tus nai saib nej koog tsev no los yog tus nai loj (Resident Connection Coordinator). Cov lus nug no muaj ntau hom lus, xws li: Mis Kas, Hmoob, Xas Mas Lis, thiab Mev. Yog leej twg ho xav yuav lwm hom lus no ces qhia rau nej tus nai saib xyuas vaj tse.','Yoo gaaffii qabaattan, hoogganaa naannoo keessanii ykn wal-taasisaa mana jireenyaa keessanii gaafadhaa. Qorannoon kun kan qophaa’e afaan Ingilizii, Hmong, Somaalii fi Spanishiitiini. Afaanoti biraas in jiraatu. Hoogganaa keessan gaafadhaa.'),
('survey', 'Home Survey', 'Encuesta de casa', 'Su’aalo Qoran oo ku Saabsan Guriga', 'Lus Nug Txog Tsev', 'Qorannoo manaa'),
('answer1', 'Strongly agree', 'Completamente de acuerdo', 'Aad Baan Ugu Raacsanahay', 'Txaus pom zoo','Guddaan
Amana'),
('answer2', 'Agree', 'De acuerdo', 'Waan Ku Raacsanahay', 'Pom zoo', 'Nan Amana'),
('answer3', 'Disagree', 'En desacuerdo', 'Waan Diiddanahay', 'Tsis pom zoo', 'Hin Amanu'),
('answer4', 'Strongly disagree', 'Definitivamente en desacuerdo', 'Aad baan u Diiddanahay', 'Txaus tsis pom zoo', 'Guddaa hin amanu'),
('logout', 'Logout', 'Cerrar la session','Ka Bax','Tua Tawm Mus', 'keessaa ba''I (logout)'),
('writeanswer', 'Write your answer here.', 'Escriba su respuesta aquí.','Halkan ku qor jawaabtaada.','Sau koj lo lus teb rau ntawm no.', 'Deebii kee as keessatti barreessi'),
('surecancel', 'Are you sure you want to cancel? This cannot be undone.', '¿Está seguro de que quiere cancelar? No podrá recuperar la información.','Ma iska hubtaa in aad joojiso? Arrintan kama noqon kartid.', 'Koj puas xav muab tso tseg tiag? Qhov no rov thim ua dua tsis tau lawm.', 'Dhuguma kana haquu barbaaddaa? Kana goonaan boodatti deebisuun hindanda''amu'),
('suresubmit', 'Are you sure you want to submit?', '¿Está seguro de que quiere completar y enviar? Ya no podrá regresar.','Ma iska hubtaa in aad rabto inaad dirto? Arrintan kama noqon kartid.', 'Koj puas xav muab xa mus tiag? Qhov no rov thim ua dua tsis tau lawm.', 'Dhuguma kana galchuu barbaaddaa?'),
('list_members', 'Please list the members of your household:', 'Por favor, enumere y mencione cada uno de los miembros de su familia:', 'Fadlan qor macluumaadka qof kasta oo qoyskaaga ka mid ah:', 'Please list the members of your household:', 'Maaloo tokkoo tokkoo maatii kee tarreessi:'),
('add_household_member', 'Add another household member', 'Añadir otro nombre de la casa', 'Ku dar xubnaha kale ee qoyska', 'Add another household member', 'Nama wallin galtu ka biraa dabaladhu'),
('name','Name','Nombre','Magac','Name','Maqaa'),
('yes','Yes','Sí','Haa','Yes', 'Eyye'),
('no','No','No','Maya','No', 'Lakki'),
('military_active','Yes - Active','Sí-Activo','Haa-Ciidanka','Yes - Active','Eyye- amma kan ta’e'),
('military_veteran','Yes - Veteran','Sí-Veterano','Haa-Hawlgab-ciidan','Yes - Veteran','Eyye- kan soorame'),
('enter_number','Enter number here.','Ingrese el número aquí','Ku qor lambarka','Enter number here.','Enter number here.'),
('remove_household_member','Remove this household member','Eliminar este miembro de la casa','Ka saar xubintan aqalka','Remove this household member','Nama wallin galtu kana manaa baasi'),
('date_of_birth','Date of Birth','Fecha De Nacimiento','Taariikhda Dhalashada','Date of Birth','Guyyaa Dhaloo taaa'),
('race_check_all','Race (check all that apply)','Raza (seleccione todas las opciones que correspondan)','Qowmiyadda (Calaamadee dhammaan wixii ku khuseeya)','Race (check all that apply)','Sanyii (Waan siif ta’u fili)'),
('race_white','White','Blanco','Caddaan','White','Adii'),
('race_black','Black','Negro o Africano Americano','Madoow ama Afrikaanka','Black','Afrikaa warra Amerikaa'),
('race_islander','Native Hawaiian or other Pacific Islander','Nativo de Hawaii o de las Islas del Pacífico','Dhaladka Haawaay ama Jasiiradaha kale','Native Hawaiian or other Pacific Islander','Dhalata Hawaiian ykn Pacific Islander'),
('race_asian','Asian','Asiático','Aasiyaan','Asian', 'Warra Asia'),
('race_native','American Indian or Alaskan Native','Indio Americano o Nativo de Alaska','Hindida Mareykanka ama Dhaladka Alaska','American Indian or Alaskan Native','Warra American Indian ykn Dhalataa Alaskaa'),
('race_other','Other:','Otro:','Qowmiyad kale:','Other:','Kabiro:'),
('race_hispanic','Hispanic or Latino','Hispano o Latino','Isbaanish ama Laatiin','Hispanic or Latino','Hispanic ykn Latino'),
('disabled','Disabled','Discapacitado','Naafo','Disabled','Qaama hir''ataa'),
('household_disclaimer', 
'Aeon also wants to learn more about who our residents are. This demographics form will help. We will ask some of the same questions on the survey and demographics form, but it is important that you fill out both. Your information will not be shared with anyone outside Aeon.',
'Aeon también desea conocer más a nuestros residentes. Este formulario de información demográfica nos ayudará a lograr esto. Algunas preguntas se repiten en la escuesta y en el formulario pero es importante que complete ambos. La información que usted provea no se compartirá con ninguna persona fuera de Aeon.',
'Aeon waxay rabaan inay faahfaahin ka helaan dadka guryaha ku nool. Waa in la qoro jawaabaha loo baahan yahay. Su''aalo noocaas ah ayaa la isku weydiinayaa daraasadda iyo waraaqda, laakiin waxaa muhiim ah in labadaba laga jawaabo. Macluumaadka dadka laga helo ma lala wadaagi doono meelo ka baxsan Aeon.',
'Tsis tas li ntawd, Aeon kuj tseem xav kawm paub ntau ntxiv txog tias seb peb cov pej xeem yog leeg twg. Daim foos sau qhia txog cov zej tsoom no yuav pab tau. Peb yuav nug qee cov lus nug uas zoo tib yam nkaus nyob rau lub sij hawm ua qhov kev tshuaj ntsuam xyuas thiab sau daim foos sau qhia txog cov zej tsoom, tab sis mam nws tseem ceeb uas koj yuav tau sau rau ob daim foos tib si. Koj cov lus qhia paub yuav tsis raug muab coj mus qhia rau ib tus neeg twg dhau ntawm Aeon lawm.',
'Aeon itti dabalataan eenyufaa akka as jiraatan baruu barbaada. Unkaan qorannoo ummataa kun ni gargaara. Gaaffiilee unkaa qo''annoo qorannoo ummataa sana irratti argaman tokko tokko ammas irra deebinee gaafanna, haa ta''u malee lamaanuu guutuun barbaachisaa dha. Odeeffannoon keessan nama Aeon ala ta''e tokkoof iyyuu hinqoodamu.'),
('lab_welcome',
'Welcome to Aeon’s computer lab/WiFi. We have a few questions before you enter the internet.',
'Bienvenido al laboratorio de computadores / WiFi de Aeon, tenemos algunas preguntas antes de que usted pueda entrar al Internet.',
'Ku soo dhawoow qolka kambuyuutarka / WiFi Aeon, intaadan internetka isticmaalin ka hor waxaa lagu weydiinayaa dhowr su''aalood.',
'Zoo siab tos txais tuaj rau ntawm Aeon chav sim kuaj mob hauv Computer (Koos Pis Tawj) / WiFi, peb muaj ob peb cov lus nug ua ntej koj yuav nkag siv internet (is taws nej).',
'Baga gara laabii / WiFi Aeon nagaan dhuftan, interneeta seenuu keessan dura gaaffilee qabna.'
),
('select_property',
'Please Select Your Property',
'Por favor seleccione su propiedad',
'Fadlan Noo Sheeg Gurigaad Deggen Tahay',
'Thov Xaiv Koj Qhov Av Vaj Tsev',
'Maaloo gamoo keessan filadhaa'
),
('computer_select_age',
'Age - of person using computer',
'Edad de la persona que usará el computador',
'Da’da – qofka isticmaalaya kambuyuutarka.',
'Hnub nyoog – ntawm tus neeg uas siv computer (koos pis tawj).',
'Umurii – nama kompuutera gargaaramu'
),
('age_0',
'0-5',
'0-5',
'0 ilaa 5',
'0-5',
'0-5'
),
('age_1',
'6-10',
'6-10',
'6 ilaa 10',
'6-10',
'6-10'
),
('age_2',
'11-15',
'11 ilaa 15',
'11-15',
'11-15',
'11-15'
),
('age_3',
'16-19',
'16-19',
'16 ilaa 19',
'16-19',
'16-19'
),
('age_4',
'20-30',
'20-30',
'20 ilaa 30',
'20-30',
'20-30'
),
('age_5',
'31-40',
'31-40',
'31 ilaa 40',
'31-40',
'31-40'
),
('age_6',
'41-50',
'41-50',
'41 ilaa 50',
'41-50',
'41-50'
),
('age_7',
'51-59',
'51-59',
'51 ilaa 59',
'51-59',
'51-59'
),
('age_8',
'60+',
'60+',
'60 jir ama ka jir',
'60+',
'60+'
),
('lab_reason',
'Reason for visiting the computer lab',
'Razón de su visita al laboratorio de computadores',
'Sababtaada Imaanshaha Qolka Kambuyuutarka',
'Laj thawj rau Kev Mus Ntsib Chav Sim Kuaj Mob Hauv Computer (Koos Pis Tawj)',
'Sababa laabii kompuuteraa dhuftaniif'
),
('school_work',
'School Work',
'Trabajo de la escuela',
'Casharrada iskuulka',
'Hauj lwm hauv tsev kawm ntawv',
'Hojii mana barnootaaf'
),
('job_search',
'Job Search',
'Búsqueda de empleo',
'Shaqo-raadin',
'Nrhiav Hauj Lwm',
'Hojii barbaachuudhaaf'
),
('unemployment_benefits',
'Unemployment Benefits',
'Beneficios de desempleo',
'Lacagta Ceymiska Shaqada',
'Cov Txiaj Ntsig Uas Tau Txais Los Ntawm Kev Tsis Muaj Hauj Lwm Ua',
'Kaffaltii hoj-dhablummaaf'
),
('covid_resources',
'COVID Resources',
'Recursos de COVID',
'Macluumaadyada COVID',
'Cov Chaw Muab Kev Pab Cuam Ntsig Txog Tus Kab Mob Khaus Viv (COVID)',
'Qabeenyaalee COVID-19 f'
),
('assistance',
'Assistance',
'Asistencia',
'Caawimaad',
'Kev Pab',
'Gargaarsaa'
),
('rent_cafe',
'Rent Café',
'Rent Café',
'Kira-bixinta Rent Café',
'Khw Noj Mov Uas Xauj',
'Café kiraaf'
),
('other',
'Other',
'Otro',
'Wax kale',
'Lwm Yam',
'Ka biroo'
)

INSERT INTO questions
    (question_number,
    english,
    somali,
    spanish,
    hmong,
    oromo,
    theme,
    year)
VALUES
    (1,
        'I feel safe in my apartment unit.',
        'Waxaan ku dareemaa ammaan abaarmankayga gudahiisa.',
        'Yo siento seguro en mi apartamento.',
        'Nyob hauv kuv chav tsev no, kuv tau luag (tsis ntshai dab tsi).',
        'Apartamaa kootti nageenya qaba.',
        'Safety',
        2019),
    (2,
        'I feel safe in the public areas inside my building (outside my apartment unit).',
        'Waxaan ku dareemaa ammaan goobaha dadwaynaha ee ku dhex yaal dhismahayga (ee ka baxsan abaarmankayga).',
        'Yo siento seguro es los lugares públicos adentro mi edifico (y fuera mis cuartos de apartamento).',
        'Nyob sab hauv lub tsev loj loj no, kuv tau luag (tawm ntawm kuv lub qhov rooj sab nrauv).',
        'Nageenyi kan natti dhaga’amu mana keessaa alatti.',
        'Safety',
        2019),
    (3,
        'I feel safe in outdoor areas near my building.',
        'Waxaan ku dareemaa ammaan goobaha bannaanka ee u dhow dhismahayga.',
        'Yo siento seguro en los lugares para afuera que son cerca de mi edificio.',
        'Nyob ib ncig sab nraum zoov kuv tau luag.',
        'Nageenyi kan natti dhaga’amu qeeyee mana kootiitti.',
        'Safety',
        2019),
    (4,
        'I feel safe in the neighborhood in which I live.',
        'Waxaan ku dareemaa ammaan xaafadda aan ku noolahay.',
        'Yo siento seguro en el barrio en donde vivo.',
        'Ib ncig ze ntawm peb lub tsev no, kuv tau luag.',
        'Nageenyi kan natti dhag’agmu ollaakoo wajjini.',
        'Safety',
        2019),
    (5,
        'I help take care of my building.',
        'Waxaan gacan ka geystaa daryeelka dhismahayga.',
        'Yo ayudo cuidar de mi edificio.',
        'Kuv yeej pab tu peb lub tsev no thiab.',
        'Apartamaa koo kunuunsaan qabuuf nan tattaaffadha.',
        'Engagement',
        2019),
    (6,
        'I report problems in my apartment ',
        'Waxaan uga warbixiyaa dhibaatooyinka ka jira abaarmankayga maamulaha goobta.',
        'Yo informo problemas en mis cuartos al manager de mi sitio.',
        'Yog kuv chav tsev muaj teeb meem dab tsi, kuv yuav qhia rau tus saib xyuas lub tsev no.',
        'Yoo rakkoon jiraate hoogganaatti nan gabaasa.',
        'Engagement',
        2019),
    (7,
        'I report problems in my building to my site manager or the police.',
        'Waxaan uga warbixiyaa dhibaatooyinka ka jira dhismahayga maamulaha goobta ama booliska.',
        'Yo informo problemas en mi edificio al manager del sitio o la policía.',
        'Yog muaj teeb meem rau peb lub tsev no, kuv yuav qhia rau tus saib xyuas los yog tub ceev xwm.',
        'Rakkoo jiru hoogganaa gamoo ykn polisiitti nan gabaasa',
        'Engagement',
        2019),
    (8,
        'I avoid talking to other people in my building.',
        'Waxaan iska ilaaliyaa inaan la hadalo dadka kale ee dhismahayga.',
        'Yo evito hablar con otras personas en mi edificio.',
        'Kuv zam kom dhau thiab tsis nrog lwm tus neeg xauj tsev hauv no sib tham.',
        'Namoota biraa gamookoo keessa jiranii wajjin haasaa nan dheessa.',
        'Engagement',
        2019),
    (9,
        'I help my neighbors in my building.',
        'Waan caawiyaa deriskayga ku nool dhismahayga.',
        'Yo ayudo mis vecinos en mi edifico.',
        'Kuv pab lwm tus neeg uas xauj tsev nyob hauv lub tsev loj loj no. git stat',
        'Olloofakoo hunda na gargaara.',
        'Engagement',
        2019),
    (10,
        'I participate in events in my building.',
        'Waxaan ka qayb qaataa dhacdooyinka ka jira dhismahayga.',
        'Yo participo en los eventos en mi edificio.',
        'Yog hauv lub tsev loj loj no muaj sib tham tej ntawd, kuv kam koom thiab.',
        'Qophii gamoo keessatii adeemsifamu keessatti nan hirmaadha.',
        'Engagement',
        2019),
    (11,
        'I participate in events in my neighborhood.',
        'Waxaan ka qayb qaataa dhacdooyinka ka jira xaafaddayda.',
        'Yo participo en los eventos en mi vecindad.',
        'Yog cov neeg nyob ib ncig no muaj sib tham ntej ntawd, kuv kam koom thiab.',
        'Qophii hawaasa ollaa keessattis nan hirmaadha.',
        'Engagement',
        2019),
    (12,
        'I help my building or community.',
        'Waan caawiyaa dhismahayga ama beeshayda.',
        'Yo ayudo mi comunidad.',
        'Kuv pab cov neeg hauv peb lub tsev no, thiab pab cov neeg hauv zej zog no tib si.',
        'Gamoo ykn hawaasa koo nan gargaara.',
        'Engagement',
        2019),
    (13,
        'I talk to five or more of my neighbors every week.',
        'Waxaan la hadlaa shan ama in ka badan dadka dariskayga ah toddobaad kasta.',
        'Yo hablo con cinco o más de mis vecinos cada semana.',
        'Ib lub as thiv twg, kuv nrog yam tsawg kawg tsib (5) tug neeg uas nyob hauv lub tsev no sib tham.',
        'Torban keesatti namoota 5 ykn caala wajjin wal- quunnamtii nan godha.',
        'Engagement',
        2019),
    (14,
        'I have decorated or personalized my apartment unit.',
        'Waan qurxistay oo aan si gaar u sharraxday abaarmankayga.',
        'Yo he personalizado o decorado mi apartamento.',
        'Kuv muab kuv chav tsev no lo ub lo no los yog tu kom zoo nkauj raws li kuv nyiam.',
        'Apaartamaa koo dhuunfaatti miidhagseera.',
        'Ownership',
        2019),
    (15,
        'I feel proud of my apartment unit.',
        'Waxaan ku dareemaa sharaf abaarmankayga.',
        'Yo siento orgulloso de mi apartamento.',
        'Kuv zoo siab hlo rau kuv chav tsev.',
        'Appaartamaa kootti nan boona.',
        'Ownership',
        2019),
    (16,
        'The overall condition of my apartment unit is excellent.',
        'Xaaladda guud ee abaarmankaygu waa heer sare.',
        'La condición general de mi apartamento esta excelente.',
        'Kuv chav tsev no huv si thiab zoo heev.',
        'Haalli apaartamaa kootii walumaagalatti gudhaa gaariidha.',
        'Staff Performance',
        2019),
    (17,
        'Overall professionalism of staff and quality of customer service is excellent.',
        'Dhaqanka guud ee xirfadyaqaanimada shaqaalaha iyo tayada adeegga macaamiisha ayaa heer sare ah.',
        'El profesionalismo general del personal y calidad del servicio a la atención de cliente esta excelente.',
        'Cov neeg ua hauj lwm saib xyuas peb lub tsev no yog neeg txawj ntse thiab coj zoo heev.',
        'Haalli ogummaafi dhiyeessiin tajaajilaa gudhaa gaariidha',
        'Staff Performance',
        2019),
    (18,
        'The overall condition of my apartment building is excellent.',
        'Xaaladda guud ee dhismaha abaarmankayga ayaa heer sare ah.',
        'La condición general de mi edifico esta excelente.',
        'Peb lub tsev loj loj no tshiab, huv, thiab zoo heev.',
        'Haalli waliigalaa kan apaartamichaa guddaa gaardiiha.',
        'Staff Performance',
        2019),
    (19,
        'My apartment unit feels like home.',
        'Abaarmankayga ayaa ka dareemaa meel hoy ii ah.',
        'is cuartos de apartamento sientan como un hogar.',
        'Chav tsev uas kuv xauj no, kuv yeej nyiam thiab saib tam nkaus li yog kuv lub tsev tiag tiag ntag.',
        'Apaartamaan koo akka mana kootiiti.',
        'Theme Not Known',
        2019),
    (20,
        'I would recommend this apartment building to others.',
        'Anigu waxaan kula talin dadka kale dhismahan. abaarman inay soo degaan.',
        'Yo recomendaría este edificio de cuartos a otras personas.',
        'Kuv yeej xav qhia lwm tus neeg hais tias lub tsev no zoo thiab kom lawv los xauj nyob.',
        'Namoonni biraan akka keessa jiraatan na gorsa.',
        'Ownership',
        2019),
    (21,
        'What makes your apartment feel like home?',
        'Maxaa ka dhiga in hoy laga dareemo abaarmankaaga?',
        '¿Qué hace sentir tu apartamento como un hogar?',
        'Yam twg uas yog yam ua rau koj nyiam lub tsev no thiab saib zoo tam li yog koj lub tsev tiag tiag?',
        'Apaartamaan keessan akka mana kessanii ta’uusaaf ragaa maalii qabdu?',
        'Theme Not Known',
        2019),
    (22,
        'What could be done to make your apartment more like home?',
        'Maxaa ah in lagu kaco si looga dhigo abaarmaankaaga hoy kuu habboon?',
        '¿Qué puede hacer para poner tu apartamento más como un hogar?',
        'Tshuav dab tsi thiab uas koj xav kom peb ua es koj thiaj saib lub tsev no li yog koj lub tiag tiag?',
        'Apaartamaa keessaan caalaatti wayyeessuuf maaltu ta’uu qaba jettu?',
        'Theme Not Known',
        2019),
    (23,
        'How long have you been a resident at this apartment building?',
        'Muddo intee le''eg ayaad deggenayd dhismahan abaarman?',
        '¿Por cuanto tiempo ha sido Usted un residente de este edificio?',
        'Koj twb los xauj lub tsev no nyob tau ntev li cas los lawm?',
        'Apaartamaa kana kessa yeroo hagamiif jiraatan?',
        'Demographics',
        2019),
    (24,
        'Please select the category that best describes your ethnicity:',
        'Xulo qaybta sida ugu fiican u qeexeysa qoymiyaddaada:',
        'Por favor elige la categoría que describe tu etnicidad mejor:',
        'Qhia seb koj yog haiv neeg dab tsi:',
        'Qomoon keessan isa kam akka ta’e kan kanaa gadii keessaa filadhaa.',
        'Demographics',
        2019),
    (25,
        'Gender',
        'Jinsi:',
        'Género:',
        'Koj Yog Poj Niam Los Txiv Neej',
        'Kornayaa:',
        'Demographics',
        2019),
    (26,
        'Age',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Age',
        'Demographics',
        2019),
    (27,
        'Your household income is:',
        'Dakhliga reerkaagu waa:',
        'Su ingreso del hogar es:',
        'Nej tsev neeg khwv tau nyiaj:',
        'Galii Manaa:',
        'Demographics',
        2019),
    (28,
        'Name of head of household:',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Teessoo Gamoo:',
        'Household',
        2019),
    (29,
        'How many people are in your household and live in your apartment?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Maatii kee keessaa nama meeqatu amma apaartamaa kee keessa jiraata?',
        'Household',
        2019),
    (30,
        'Does any member of your household speak English as a second language or not speak English?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Maatii kee keessaa nami Ingliffa akka afaan lammataatti dubbatu ykn hindubbanne jiraa?',
        'Household',
        2019),
    (31,
        'If yes, primary language is:',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Yoo Eyyee ta’e, afaan isa jalqabaa:',
        'Household',
        2019),
    (32,
        'Is any household member an active member or veteran of the U. S. military?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Mana kee keessaa nami miseensa loltuu US amma ta’e ykn kan soorame jira?',
        'Household',
        2019),
    (33,
        'Have you or your household experienced homelessness in the past?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Ati ykn maatiin kee man-dhablee ta’ee beekaa kana duraa?',
        'Household',
        2019),
    (34,
        'What is the amount of your household’s annual income?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Galiin maatii keetii wagga tti hagami?',
        'Household',
        2019);