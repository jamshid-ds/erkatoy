from datetime import datetime, timedelta
import pandas as pd
from fastapi import HTTPException

base_dir = 'schedule/'
files = {
    "0-4": pd.read_csv(f"{base_dir}0-4.csv"),
    "4-6": pd.read_csv(f"{base_dir}4-6.csv"),
    "6-9": pd.read_csv(f"{base_dir}6-9.csv"),
    "9-12": pd.read_csv(f"{base_dir}9-12.csv"),
    "12-18": pd.read_csv(f"{base_dir}12-18.csv"),
    "18-24": pd.read_csv(f"{base_dir}18-24.csv"),
    "24-32": pd.read_csv(f"{base_dir}24-32.csv")
}


def get_file_name(month: int) -> str:
    if 0 <= month < 4:
        return "0-4"
    elif 4 <= month < 6:
        return "4-6"
    elif 6 <= month < 9:
        return "6-9"
    elif 9 <= month < 12:
        return "9-12"
    elif 12 <= month < 18:
        return "12-18"
    elif 18 <= month < 24:
        return "18-24"
    elif 24 <= month < 32:
        return "24-32"
    else:
        return "24-32"


def calculate_age(baby_birth_date_str: str) -> int:
    birth_date = datetime.strptime(baby_birth_date_str, "%d.%m.%Y")
    current_date = datetime.now()
    age_in_months = (current_date.year - birth_date.year) * 12 + current_date.month - birth_date.month
    return age_in_months


def get_current_time() -> str:
    current_time = datetime.now()
    return current_time.strftime("%H:00")


def find_activity(df, time):
    activity = df[df['Vaqt'] == time]['Faoliyat']

    if activity.empty:
        previous_hour = (datetime.strptime(time, "%H:%M") - timedelta(hours=1)).strftime("%H:%M")
        activity = df[df['Vaqt'] == previous_hour]['Faoliyat']

        if activity.empty:
            half_hour_before = (datetime.strptime(time, "%H:%M") - timedelta(minutes=30)).strftime("%H:%M")
            half_hour_after = (datetime.strptime(time, "%H:%M") + timedelta(minutes=30)).strftime("%H:%M")

            activity = df[df['Vaqt'] == half_hour_before]['Faoliyat']
            if activity.empty:
                activity = df[df['Vaqt'] == half_hour_after]['Faoliyat']

            if activity.empty:
                raise HTTPException(status_code=404,
                                    detail="Activity not found for the given time or nearest half-hour")

    return activity.iloc[0]
