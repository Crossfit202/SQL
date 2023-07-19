import mysql.connector
from datetime import datetime
import tkinter as tk
from tkinter import ttk

def search_hymns_by_topic_and_category():
    topic = topic_entry.get()
    category = category_entry.get()

    # Establish a connection to the MySQL database
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="Cro$$57jon",
        database="hymns"
    )

    try:
        # Create a cursor to execute SQL queries
        cursor = db.cursor()

        # Prepare the SELECT statement
        if topic == "" and category == "":
            query = "SELECT hymn_number, hymn_name FROM hymn WHERE (DATEDIFF(CURDATE(), last_played) > 180 OR last_played IS NULL) ORDER BY ranking DESC"
            cursor.execute(query)
        elif topic != "" and category == "":
            query = "SELECT hymn_number, hymn_name FROM hymn WHERE (topic = %s ) AND (category = %s OR category = 'anything' OR category = 'opening' OR category = 'closing' OR category = 'intermediate') AND (DATEDIFF(CURDATE(), last_played) > 180 OR last_played IS NULL) ORDER BY ranking DESC"
            cursor.execute(query, (topic, category))
        elif topic != "" and category != "":
            query = "SELECT hymn_number, hymn_name FROM hymn WHERE (topic = %s ) AND (category = %s OR category = 'anything') AND (DATEDIFF(CURDATE(), last_played) > 180 OR last_played IS NULL) ORDER BY ranking DESC"
            cursor.execute(query, (topic, category))
        elif topic == "" and category != "":
            query = "SELECT hymn_number, hymn_name FROM hymn WHERE (topic = %s OR topic IS NULL) AND (category = %s) AND (DATEDIFF(CURDATE(), last_played) > 180 OR last_played IS NULL) ORDER BY ranking DESC"
            cursor.execute(query, (topic, category))

        # Fetch all the rows returned by the query
        rows = cursor.fetchall()

        # Clear previous results from the table
        clear_table()

        # Display the results in the table
        if rows:
            for row in rows:
                hymn_number, hymn_name = row
                table.insert("", "end", values=(hymn_number, hymn_name))
        else:
            table.insert("", "end", values=("No results found.", ""))

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        # Close the cursor and database connection
        cursor.close()
        db.close()

def clear_table():
    # Remove all previous results from the table
    records = table.get_children()
    for record in records:
        table.delete(record)

def select_hymn():
    selected_item = table.focus()
    hymn_number = table.item(selected_item)['values'][0]
    
    # Create a new window for hymn selection and date entry
    hymn_window = tk.Toplevel(root)
    hymn_window.title("Hymn Selection")
    hymn_window.geometry("300x150")
    
    # Create the input fields for hymn number and date
    hymn_number_label = tk.Label(hymn_window, text="Hymn Number:")
    hymn_number_label.pack()
    hymn_number_entry = tk.Entry(hymn_window)
    hymn_number_entry.pack()
    
    date_label = tk.Label(hymn_window, text="Date (YYYY-MM-DD):")
    date_label.pack()
    date_entry = tk.Entry(hymn_window)
    date_entry.pack()
    
    # Create the submit button
    submit_button = tk.Button(hymn_window, text="Submit", command=lambda: update_last_played(hymn_number_entry.get(), date_entry.get(), hymn_window))
    submit_button.pack()

def update_last_played(hymn_number, date, hymn_window):
    # Establish a connection to the MySQL database
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="Cro$$57jon",
        database="hymns"
    )

    try:
        # Create a cursor to execute SQL queries
        cursor = db.cursor()

        # Prepare the UPDATE statement
        query = "UPDATE hymn SET last_played = %s WHERE hymn_number = %s"
        cursor.execute(query, (date, hymn_number))
        db.commit()
        
        # Close the hymn selection window
        hymn_window.destroy()
        
    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        # Close the cursor and database connection
        cursor.close()
        db.close()

# Create the main window
root = tk.Tk()
root.title("Hymn Search")
root.geometry("1000x500")

# Create the input fields
topic_label = tk.Label(root, text="Topic:")
topic_label.pack()
topic_entry = tk.Entry(root)
topic_entry.pack()

category_label = tk.Label(root, text="Category:")
category_label.pack()
category_entry = tk.Entry(root)
category_entry.pack()

# Create the search button
search_button = tk.Button(root, text="Search", command=search_hymns_by_topic_and_category)
search_button.pack()

# Create the table to display the results
table = ttk.Treeview(root, columns=("Hymn Number", "Hymn Name"), show="headings")
table.heading("Hymn Number", text="Hymn Number")
table.heading("Hymn Name", text="Hymn Name")
table.pack()

# Create the select button
select_button = tk.Button(root, text="Select Hymn", command=select_hymn)
select_button.pack()

root.mainloop()
