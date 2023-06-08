# vCoach-Backend
### 📍 Technologies
&ensp;<img src="https://user-images.githubusercontent.com/71220483/167238852-78f6a958-0037-4d08-a1a1-52f488454529.svg" width="80"/> &nbsp; <img src="https://user-images.githubusercontent.com/71220483/167238874-e12bf41b-7ce6-4c07-a822-26d443dc3164.svg" width="40"/> &nbsp;  <img src="https://raw.githubusercontent.com/MaccaTech/PostgresPrefs/master/PostgreSQL/Images/elephant.png" width="40"/> &nbsp; 
---
 ### 📍 Prerequisites
* you need to have docker installed on your machine
---
### 🛠 Instructions
---
&ensp; After cloning this repo  
1. ``` $ cd vCoach-Backend ```
2. ``` $ cp env.template .env ```
3. ``` $ chmod +x docker-entrypoint.sh ```
4. ``` $ docker compose up ```  

* Access API through:
    > http://localhost:3001
* Access Database through:
    > http://localhost:5433

### ``` ⚠️ Note: .SSH directory is copied into the container so you can make your git commands from the container if you have you .git configured to work with SSH keys  ``` 

### ``` ⚠️ Note: The migrations are done by default when starting up the container but if you want to run any commands within the container you can exec bash   ``` 


