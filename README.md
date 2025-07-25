# Online Quiz Portal with Random Question Paper Generation and Load Balancer
![](./images/logo.png)
## Introduction
Genesis (Random Quiz Generator) can be used in schools, institutions, colleges, and by other test paper setters who want to have a huge database of questions for frequent generation of question. You can create random question paper for each student with this software anytime within seconds. One can make many sets of paper from one database.
### Six types of questions are provided:
1. Multiple Choice Type
1. Numerical Type
1. Dropdown Type
1. Fill in the blanks Type
1. Short answer Type
1. Essay Type

Question paper is generated **dynamically and randomly** when a student clicks on the button to attempt a quiz. Full customization of quiz configuration is provided to the instructor. Number of questions of each type, total number of questions, marks for each type of question and maximum marks along with the duration of the quiz can all be set by the instructor. It is a **distributed application** for distributed online quiz. The project also includes organization of question bank, and making system highly available. **High Availability** is provided using replicated servers and static load balancing technique improves the throughput of the whole system.

## Features
1. Random quiz generation
1. Session Maintenance
1. Quiz configuration
1. Quiz Response Store
1. Distributed database
1. More than one server to handle request
1. Load balancing
1. Question paper Requests using RPC
1. Fault tolerance

### Technology Used
* HTML
* CSS
* Javascript
* MySQL
* PHP
* PHPMyAdmin
* Template For Website : Material Design Template
    * https://www.creative-tim.com/product/material-kit

### Project Structure
The repository contains the following folders:

```
.
├── code        # PHP source files and web assets
├── images      # Screenshots referenced in the README
├── sql         # Example MySQL dump files
├── Project Proposal.pdf
├── Project Report DS.pdf
└── README.md
```

The main application code lives in the `code` directory while database schemas
are provided under `sql/`.

### **Database Information**
|Table Name|Purpose|
|---|---|
|studentinfo| Store information about the registered students|
|instrutorinfo| Store information about the Teacher and TAs|
|admininfo| Administrative user accounts with OTP secrets|
|instructor_requests| Tracks instructor modification requests|
|quizrecord| Store information about latest quiz given by students|
|response| Stores answers of the questions submitted by students|
|result| Stores information about marks of students|
|quizconfig| Stores configuration about quiz|
|mcqdb| Stores questions which have 4 choices|
|numericaldb| Stores numerical type questions|
|dropdown| Stores question which have multiple choices|
|fillintheblanks| Stores fill in the blanks type question|
|shortanswer| Stores short answer type question|
|essay| Stores essay type answer|

### **Source Code Information** (Single Server)      
|File Name|Purpose|
|---|---|
|**database.php**|Stores Database Cofiguration|           
|**instructorlogin.php**|Login Page for Instructor|    
|**instructorhome.php**|Home Page for Instructor|     
|**questionfeed.php**|Question Feeding into Question Bank|      
|**quizconfig.php**|Quiz Configuration Page|        
|**instructorlogout.php**|Logout for Instructor|   
|**studentregister.php**|Register Page for Students|
|**studentlogin.php**|Login Page for Students|
|**studenthome.php**|Home Page for Students|
|**quizhome.php**|Quiz Home Page|          
|**randomqgen.php**|Random Question Papers Generation Function|        
|**quizpage.php**|Live Quiz Page|          
|**jump.php**|Jump to Question Number Function|               
|**submit.php**|Submit Function for Quiz|
|**studentlogout.php**|Logout for Students|
### **Source Code Information** (Multiple Server)  
|File Name|Purpose|
|---|---|           
|**servers.php**|Stores IP of servers|
|**questiondatabase.php**|Stores IP of question bank servers|  
|**multiquestionfeed.php**|Simultaneous question feed into all servers|  
|**redirect.php**|Redirect Page on Load Balancer|         
|**randomredirect.php**|Random Redirect Page on Load Balancer|    
|**weightedredirect.php**|Weighted Redirect Page on Load Balancer|
|**weightedservers.php**|Stores weighted server ip address|
---
### Architecture Model
![](./images/architecture.png)

### Use Case Model
![](./images/usecase.png)
---

## Run Project
* Clone Repository 
```
git clone https://github.com/ft-abhishekgupta/php-mysql-onlinequizportal
```
* Install Dependencies :
    * Apache Server
    * MySQL
    * PHP

* Copy files in code to Apache Directory : ```var/www/html/```

* Open PHPMyAdmin
    1. Create Database **quiz**
    1. Import ```sql/database_quiz.sql``` in the database

* Modify ```database.php``` file with MySQL Credentials
* Open Browser :
    * Open **localhost/instructorlogin.php** : For Admin Panel
        * Username : instructor@gmail.com
        * Password : password
    * Open **localhost/studentlogin.php** : For Students Panel
        * Username : 123
        * Password : 123
---
## Use Project
You can use this project directly to conduct a quiz.
Just Follow these steps :
1. Run the project
1. Use PHPMyAdmin to clear the tables in database
1. Create new instructor in database.
1. Use **instructorlogin** page to insert questions and quiz configuration
1. Give **(Server IP Address)/studentregister.php** link to students.
1. The quiz runs on lan without any modification.
---
## Set Up Load Balancer
This step is only for setting up multiple servers for the quiz.
* Replicate Server Setup in multiple systems 
* Add Each Server Ip Addresses to ```servers.php```
* Select one server as the Load Balancer.
* Enable remote mysql access for each server.
* Open PHPMyAdmin in Load Balancers
    1. Create Database **load**
    1. Import ```load.sql``` in the database
* Give **(Load Balancer IP Address)/redirect.php** link to students.

Multi Server Question Feed also works in this configuration, where instructor can feed questions into multiple servers simultaneously.

### Other Load Balancer Implementation
* **Random** : use ```randomredirect.php```

* **Weighted** : use ```weightedredirect.php``` (also modify *weightedservers.php* file)
----
## Screenshots
![](./images/Screenshot1.png)
![](./images/Screenshot2.png)
![](./images/Screenshot3.png)
![](./images/Screenshot4.png)
![](./images/Screenshot5.png)
![](./images/Screenshot6.png)
![](./images/Screenshot7.png)
![](./images/Screenshot8.png)
![](./images/Screenshot9.png)
![](./images/Screenshot10.png)
![](./images/Screenshot11.png)
![](./images/Screenshot12.png)
![](./images/Screenshot13.png)
![](./images/Screenshot14.png)
## Fixing mismatched topic IDs
If MCQ questions for a topic are missing from the selection modal, the topic identifiers in `mcqdb` might not match the IDs in the `topics` table.
Run the helper script to realign them. The script now accepts an optional topic name
and search term so it can be used for any topic:

```bash
php "code/Extra files/fix_topic_ids.php" "Domain Archaea" "Archaea"
```
This example updates MCQ records containing "Archaea" to use the current ID for "Domain Archaea".

## Development Notes

All PHP files were linted using `php -l` and no syntax errors were detected.

When installing the optional Node.js tooling for SCSS compilation, use Node 20+
and run `npm install`. The project now uses `gulp-sass` version 5 with the
`sass` package, avoiding build errors from the deprecated `node-sass` bindings.

---

    

### Android App
A basic Android application is included under the `android/` folder. It loads the web portal inside a `WebView`. Import this folder into Android Studio to build and run the app. Update the URL in `MainActivity.kt` to point to the server hosting the PHP application.
The Gradle wrapper JAR is not included; instead `android/gradle/wrapper/gradle-wrapper.jar` contains a placeholder text. Replace this file with the real `gradle-wrapper.jar` from a standard Android Studio project before building.
