# Overview

This program's purpose is to help me pick hymns on a weekly basis based on topic and category. It is also filtered by the last date it was played to avoid overuse. 

I am the chorister at my Church so I'm in charge of selecting the songs from a group of 300+ hymns. This program shows me what weeks I have already planned, allows me to add more weeks, and add the hymns I want to sing in those weeks easily and efficiently in a User-Friendly GUI. 

The Python program I used is connected to a MySQL database with all the hymns in it. 

[Software Demo Video](https://youtu.be/lRLzCV5rDKQ)

# Relational Database

I am using a MySQL database. It contains a main table of all of the hymns. The program can also create any tables that the user desires when they pick hymns for the week. 

The tables are not related to each other. They are able to be displayed individually without foreign key requirements. 

# Development Environment

I utilized several libraries and development tools:

Python Programming Language

Visual Studio Code (IDE)

Tkinter - Tkinter is a standard Python library for creating graphical user interfaces (GUIs). I used it to build the main window, input fields, buttons, and display tables.

mysql.connector - This is a Python library that provides a connection and interaction interface with MySQL databases. I used it to execute SQL queries, and retrieve data.

datetime - this was used to perform date comparisons.

re: this was used to manipulate and format table names in regular expression.

subprocess: The subprocess module is a standard library module that allows you to spawn new processes, connect to their input/output/error pipes, and obtain their return codes. I used this as a refresh on my program. 

# Useful Websites

{Make a list of websites that you found helpful in this project}

- [Python Documentation](https://docs.python.org/)
- [Tkinter Documentation](https://docs.python.org/3/library/tkinter.html)
- [MySQL Connector/Python Documentation](https://dev.mysql.com/doc/connector-python/en/)

# Future Work

Things I would like to improve in the future:

- Color Scheme and GUI design
- Calendar to pick the date from instead of typing it in. This will eliminate a lot of typos and user error. 
- Links to listen to the music and view the sheet music from the ChurchofJesusChrist.org