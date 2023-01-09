#!/usr/bin/env python3
import os
import pickle
import sys

from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from google.auth.transport.requests import Request

API_SERVICE_NAME = "youtube"
API_VERSION = "v3"
CLIENT_SECRETS_FILE = "YOUR_CLIENT_SECRET_FILE.json"
SCOPES = ["https://www.googleapis.com/auth/youtube.force-ssl"]


def save_credentials(creds_obj):
    with open('token.pickle', 'wb') as f:
        print('Saving Credentials for Future Use...')
        pickle.dump(creds_obj, f)


def load_credentials():
    if os.path.exists('token.pickle'):
        print('Loading Credentials From File...')
        with open('token.pickle', 'rb') as token:
            return pickle.load(token)


def get_credentials():
    credentials = load_credentials()
    if credentials and credentials.expired:
        print('Refreshing Access Token...')
        credentials.refresh(Request())
        return credentials

    # if credentials is None or not credentials.valid:
    flow = InstalledAppFlow.from_client_secrets_file(CLIENT_SECRETS_FILE, SCOPES)
    credentials = flow.run_local_server()
    save_credentials(credentials)
    return credentials


def main(args):
    _id = args[1].split("?v=")[1]
    credentials = get_credentials()
    youtube = build(API_SERVICE_NAME, API_VERSION, credentials=credentials)
    request = youtube.videos().rate(id=_id, rating="like")
    request.execute()

    print("\n>>> Liked Successfully <<<")


if __name__ == "__main__":
    main(sys.argv)
    sys.exit(0)
