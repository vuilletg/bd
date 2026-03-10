import sqlite3
from sqlite3 import Error

def create_connection(sqlfilepath, db_file):
    try:
        conn = sqlite3.connect(db_file)
        cur = conn.cursor()
        with open(sqlfilepath, 'r', encoding='utf-8') as sql_file:
            sql_script = sql_file.read()
        
        cur.executescript(sql_script)
        conn.commit()
        return conn
    except Error as e:
        print(f"Erreur SQL : {e}")
    except FileNotFoundError:
        print("Erreur : Le fichier .SQL est introuvable.")
    return None

def select_buveurs(conn):
    cur = conn.cursor()
    query = "SELECT DISTINCT nomB, PrenomB FROM Personne JOIN bois ON bois.client = Personne.id"
    cur.execute(query)
    rows = cur.fetchall()
    
    print("\nListe des buveurs :")
    for row in rows:
        print(f"{row[0]} {row[1]}")

def select_note_bar(conn):
    cur = conn.cursor()
    query = "SELECT nomB, avg (note) from Bar join avis on bar=id group by nomB order by avg (note) DESC"
    cur.execute(query)
    rows = cur.fetchall()
    
    print("\nNote Bar :")
    for row in rows:
        print(f"{row[0]} {row[1]}")

def select_client_aigris (conn):
    cur = conn.cursor()
    query = "SELECT nomB, PrenomB from Personne join avis on personne=id group by nomB order by avg (note) ASC limit 1"
    cur.execute(query)
    rows = cur.fetchall()
    
    print("\nNote Bar :")
    for row in rows:
        print(f"{row[0]} {row[1]}")

def select_menteurs (conn):
    cur = conn.cursor()
    query = "Select nomB, prenomB from Personne join avis on personne =id EXCEPT Select nomB, prenomB from Personne join Avis on personne= id join Bois on client = id where Bois.bar = Avis.Bar"
    cur.execute(query)
    rows = cur.fetchall()
    
    print("\nNote Bar :")
    for row in rows:
        print(f"{row[0]} {row[1]}")

def select_patron_sobre (conn):
    cur = conn.cursor()
    query = "Select Personne.nomB, prenomB from Personne join Bar on patron =id EXCEPT Select nomB, prenomB from Personne join Avis on personne= id"
    cur.execute(query)
    rows = cur.fetchall()
    
    print("\nNote Bar :")
    for row in rows:
        print(f"{row[0]} {row[1]}")

def main():
    print("Création de la base...")
    conn = create_connection("./create.SQL", "beeer.db")
    
    if conn:
        select_buveurs(conn)
        select_note_bar(conn)
        select_client_aigris(conn)
        select_menteurs(conn)
        conn.close()
    else:
        print("Impossible de se connecter à la base de données.")

if __name__ == "__main__":
    main()