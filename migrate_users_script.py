
import os
import django
import psycopg2
from datetime import datetime

# 1. Setup Django (Target: Aiven Remote DB)
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

from django.contrib.auth import get_user_model
User = get_user_model()

# 2. Local DB Credentials
LOCAL_CONFIG = {
    'dbname': 'lylybakery_db',
    'user': 'postgres',
    'password': 'CVR5002Ma@@@',
    'host': 'localhost',
    'port': '5432'
}

TARGET_EMAILS = ['dalinigba@gmail.com', 'daligba83@gmail.com']

def run_migration():
    print("--- Starting User Migration ---")
    
    # Connect to Local DB
    try:
        conn = psycopg2.connect(**LOCAL_CONFIG)
        cursor = conn.cursor()
        print(f"Connected to local database: {LOCAL_CONFIG['dbname']}")
    except Exception as e:
        print(f"Error connecting to local database: {repr(e)}")
        import traceback
        traceback.print_exc()
        return

    for email in TARGET_EMAILS:
        print(f"\nProcessing: {email}")
        
        # Check if user already exists in Remote (Target)
        if User.objects.filter(email=email).exists():
            print(f"  -> User {email} already exists in remote DB. Skipping.")
            continue

        # Fetch from Local
        # Note: Adjust column names if your User model differs (e.g. built-in User vs Custom User)
        # Assuming Custom User Model: accounts_user
        # Columns typically: id, password, last_login, is_superuser, first_name, last_name, is_staff, is_active, date_joined, email, ...
        
        # specific query to get all needed fields
        # Using * is risky if schema changed, but let's try to be specific or map dynamically
        try:
            cursor.execute("SELECT email, password, is_superuser, is_staff, is_active, first_name, last_name, date_joined FROM accounts_user WHERE email = %s", (email,))
            row = cursor.fetchone()
            
            if not row:
                print(f"  -> User {email} NOT FOUND in local database.")
                continue
                
            email_val, password_hash, is_superuser, is_staff, is_active, first_name, last_name, date_joined = row
            
            print(f"  -> Found local user. Creating remote copy...")
            
            # Create in Remote DB
            new_user = User(
                email=email_val,
                first_name=first_name,
                last_name=last_name,
                is_superuser=is_superuser,
                is_staff=is_staff,
                is_active=is_active,
                date_joined=date_joined
            )
            # KEY: Set the password hash directly. Do NOT use set_password() which re-hashes.
            new_user.password = password_hash
            new_user.save()
            print(f"  -> SUCCESS: User {email} created in remote DB.")

        except Exception as e:
            print(f"  -> ERROR querying/migrating {email}: {e}")

    conn.close()
    print("\n--- Migration Complete ---")

if __name__ == "__main__":
    run_migration()
