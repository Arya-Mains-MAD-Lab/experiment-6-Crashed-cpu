
---

### Experiment 6 README.md

```markdown
# Experiment 6: SQLite Database Application

## Student Information
* **Name:** Ayush  
* **Roll Number:** 23EACAD025  
* **Batch:** Alpha-1  
* **Section:** G-1  
* **Department:** Artificial Intelligence & Data Science  
* **Course:** B.Tech – AI & Data Science  

---

## Aim
To integrate **SQLite database** in a Flutter application for local data storage.

---

## Procedure
1. Added `sqflite` and `path` dependencies in `pubspec.yaml`.  
2. Initialized database using `openDatabase()` with `getDatabasesPath()` and `join()`.  
3. Created a `student` table with `id` (PRIMARY KEY) and `name` fields.  
4. Implemented `initDB()` inside `initState()` to set up the database.  
5. Displayed confirmation message once database was created successfully.  

---

## Output
The application successfully creates a SQLite database and displays confirmation on screen.  

--- **Adding User**
<img src="./image.png" alt="SQLite Database Output" width="300"/>  

--- **Updating User**
<img src="./upd.png" alt="SQLite Database Output" width="300"/>  

--- **Display Screen**
<img src="./disp.png" alt="Sqlite db output" width="300"/>
---



## Conclusion
This experiment demonstrated how to integrate **SQLite database** in Flutter using the `sqflite` package for persistent local storage.

---

## How to Run
1. Ensure **Flutter SDK** is installed and added to PATH.  
2. Add dependencies in `pubspec.yaml`:  
   ```yaml
   dependencies:
     sqflite: ^2.0.0+4
     path: ^1.8.0
