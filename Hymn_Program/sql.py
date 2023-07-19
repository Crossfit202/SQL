import mysql.connector
from datetime import datetime
import tkinter as tk
from tkinter import ttk
import re
import subprocess

def refresh():
    root.destroy()
    script_path = r"C:\Users\Joncr\OneDrive\Desktop\Coding\SQL\Hymn_Program\sql.py"
    subprocess.run(["python", script_path])

def search_hymns_by_topic_and_category():
    topic = topic_entry.get()
    category = category_var.get()

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
            query = "SELECT hymn_number, hymn_name FROM hymn WHERE (topic = %s) AND (category = %s OR category = 'anything' OR category = 'opening' OR category = 'closing' OR category = 'intermediate') AND (DATEDIFF(CURDATE(), last_played) > 180 OR last_played IS NULL) ORDER BY ranking DESC"
            cursor.execute(query, (topic, category))
        elif topic != "" and category != "":
            query = "SELECT hymn_number, hymn_name FROM hymn WHERE (topic = %s) AND (category = %s OR category = 'anything') AND (DATEDIFF(CURDATE(), last_played) > 180 OR last_played IS NULL) ORDER BY ranking DESC"
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
    hymn_name = table.item(selected_item)['values'][1]

    # Create a new window for hymn selection and date entry
    hymn_window = tk.Toplevel(root)
    hymn_window.title("Hymn Selection")
    hymn_window.geometry("300x200")

    # Create the input fields for hymn number and date
    hymn_number_label = tk.Label(hymn_window, text="Hymn Number:")
    hymn_number_label.pack()
    hymn_number_entry = tk.Entry(hymn_window)
    hymn_number_entry.insert(tk.END, hymn_number)  # Set the hymn number automatically
    hymn_number_entry.config(state="readonly")
    hymn_number_entry.pack()

    date_label = tk.Label(hymn_window, text="Date (YYYY-MM-DD):")
    date_label.pack()
    date_entry = tk.Entry(hymn_window)
    date_entry.pack()

    # Create the dropdown menu for category selection
    category_label = tk.Label(hymn_window, text="Category:")
    category_label.pack()
    category_menu = ttk.Combobox(hymn_window, values=["opening", "sacrament", "closing", "intermediate"])
    category_menu.pack()

    # Create the submit button
    submit_button = tk.Button(hymn_window, text="Submit",
                              command=lambda: update_last_played(hymn_number, hymn_name, date_entry.get(),
                                                                 category_menu.get(), hymn_window))
    submit_button.pack()


def update_last_played(hymn_number, hymn_name, date, category, hymn_window):
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

        # Format the table name to include only alphanumeric characters and underscores
        table_name = re.sub(r'\W+', '_', date)

        # Create or find the table with the given name
        create_table_query = f"CREATE TABLE IF NOT EXISTS {table_name} (hymn_number INT, hymn_name VARCHAR(255), category VARCHAR(255))"
        cursor.execute(create_table_query)

        # Insert hymn number, hymn name, and category into the table
        insert_data_query = f"INSERT INTO {table_name} (hymn_number, hymn_name, category) VALUES (%s, %s, %s)"
        cursor.execute(insert_data_query, (hymn_number, hymn_name, category))
        db.commit()

        # Close the hymn selection window
        hymn_window.destroy()

        # Create a new window to display the table
        display_window = tk.Toplevel(root)
        display_window.title(f"Table: {table_name}")
        display_window.geometry("700x400")

        # Create the table widget
        display_table = ttk.Treeview(display_window, columns=("Hymn Number", "Hymn Name", "Category"), show="headings")
        display_table.heading("Hymn Number", text="Hymn Number")
        display_table.heading("Hymn Name", text="Hymn Name")
        display_table.heading("Category", text="Category")
        display_table.pack()

        # Fetch the data from the table
        fetch_data_query = f"SELECT hymn_number, hymn_name, category FROM {table_name}"
        cursor.execute(fetch_data_query)
        rows = cursor.fetchall()

        # Display the data in the table
        if rows:
            for row in rows:
                hymn_num, hymn_n, cat = row
                display_table.insert("", "end", values=(hymn_num, hymn_n, cat))  # Add the 'cat' value for category
        else:
            display_table.insert("", "end", values=("No data available.", "", ""))

        # Create the remove button
        remove_button = tk.Button(display_window, text="Remove",
                                  command=lambda: remove_from_table(table_name, display_table))
        remove_button.pack()

        # Create the delete table button
        delete_table_button = tk.Button(display_window, text="Delete Table",
                                       command=lambda: delete_table(table_name, display_window))
        delete_table_button.pack()

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        # Close the cursor and database connection
        cursor.close()
        db.close()


def remove_from_table(table_name, display_table):
    selected_item = display_table.focus()
    hymn_number = display_table.item(selected_item)['values'][0]

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

        # Prepare the DELETE statement
        delete_query = f"DELETE FROM {table_name} WHERE hymn_number = %s"
        cursor.execute(delete_query, (hymn_number,))
        db.commit()

        # Remove the selected item from the display table
        display_table.delete(selected_item)

        # Update the last_played date to NULL
        update_query = "UPDATE hymn SET last_played = NULL WHERE hymn_number = %s"
        cursor.execute(update_query, (hymn_number,))
        db.commit()

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        # Close the cursor and database connection
        cursor.close()
        db.close()


def delete_table(table_name, display_window):
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

        # Prepare the DROP TABLE statement
        drop_table_query = f"DROP TABLE IF EXISTS {table_name}"
        cursor.execute(drop_table_query)
        db.commit()

        # Close the display window
        display_window.destroy()

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        # Close the cursor and database connection
        cursor.close()
        db.close()


def view_table():
    selected_table = table_menu.get()

    # Create a new window to display the table
    display_window = tk.Toplevel(root)
    display_window.title(f"Table: {selected_table}")
    display_window.geometry("700x400")

    # Create the table widget
    display_table = ttk.Treeview(display_window, columns=("Hymn Number", "Hymn Name", "Category"), show="headings")
    display_table.heading("Hymn Number", text="Hymn Number")
    display_table.heading("Hymn Name", text="Hymn Name")
    display_table.heading("Category", text="Category")
    display_table.pack()

    # Fetch the data from the table
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="Cro$$57jon",
        database="hymns"
    )

    try:
        cursor = db.cursor()
        fetch_data_query = f"SELECT hymn_number, hymn_name, category FROM {selected_table}"
        cursor.execute(fetch_data_query)
        rows = cursor.fetchall()

        # Display the data in the table
        if rows:
            for row in rows:
                hymn_num, hymn_n, cat = row
                display_table.insert("", "end", values=(hymn_num, hymn_n, cat))  # Add the 'cat' value for category
        else:
            display_table.insert("", "end", values=("No data available.", "", ""))

        # Create the remove button
        remove_button = tk.Button(display_window, text="Remove",
                                  command=lambda: remove_from_table(selected_table, display_table))
        remove_button.pack(padx=10, pady=10)

        # Create the delete table button
        delete_table_button = tk.Button(display_window, text="Delete Table",
                                       command=lambda: delete_table(selected_table, display_window))
        delete_table_button.pack(padx=50, pady=50)

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
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

# Create the dropdown menu for category selection
category_var = tk.StringVar()
category_menu = ttk.Combobox(root, textvariable=category_var, values=["", "opening", "sacrament", "closing", "intermediate"])
category_menu.pack()

# Create the search button
search_button = tk.Button(root, text="Search", command=search_hymns_by_topic_and_category)
search_button.pack()

# Create the table to display the results
table = ttk.Treeview(root, columns=("Hymn Number", "Hymn Name"), show="headings")
table.heading("Hymn Number", text="Hymn Number")
table.heading("Hymn Name", text="Hymn Name")
table.pack(padx=10, pady=10)

# Create the select button
select_button = tk.Button(root, text="Select Hymn", command=select_hymn)
select_button.pack()

# Create the dropdown menu to select a table
table_var = tk.StringVar()
table_menu = ttk.Combobox(root, textvariable=table_var)
table_menu.pack(padx=10, pady=10)

# Fetch all the table names from the database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="Cro$$57jon",
    database="hymns"
)

try:
    cursor = db.cursor()

    # Fetch the table names from the database
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()

    # Filter out the "hymn" table
    table_names = [table[0] for table in tables if table[0] != "hymn"]

    # Set the values for the table menu
    table_menu["values"] = table_names

except mysql.connector.Error as err:
    print(f"Error: {err}")

finally:
    cursor.close()
    db.close()


# Create the view button
view_button = tk.Button(root, text="View Week", command=view_table)
view_button.pack()

# Create refresh button 

refresh_button = tk.Button(root, text="Refresh", command=refresh)
refresh_button.pack(padx=10, pady=10)

root.mainloop()
