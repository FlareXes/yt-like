#!/usr/bin/env python3

# -*- coding: utf-8 -*-

import os
import pickle
import sys

import google_auth_oauthlib.flow
import googleapiclient.discovery
import googleapiclient.errors
from google.auth.transport.requests import Request

API_SERVICE_NAME = "youtube"
API_VERSION = "v3"


def _load_credentials():
    if os.path.exists('token.pickle'):
        print('Loading Credentials From File...')
        with open('token.pickle', 'rb') as token:
            return pickle.load(token)


def _save_credentials(credentials_obj):
    with open('token.pickle', 'wb') as f:
        print('Saving Credentials for Future Use...')
        pickle.dump(credentials_obj, f)


def _is_access_token_expired(credentials):
    # credentials is an object
    if credentials and credentials.expired and credentials.refresh_token:
        # Refresh token if valid
        print('Refreshing Access Token...')
        try:
            credentials.refresh(Request())
            return False
        except Exception:
            return True


def _get_new_access_token():
    scopes = ["https://www.googleapis.com/auth/youtube.force-ssl"]
    client_secrets_file = "YOUR_CLIENT_SECRET_FILE.json"

    flow = google_auth_oauthlib.flow.InstalledAppFlow.from_client_secrets_file(
        client_secrets_file, scopes)
    flow.run_local_server()
    credentials = flow.credentials
    _save_credentials(credentials)
    return credentials


def _like_video(credentials, _id):
    youtube = googleapiclient.discovery.build(API_SERVICE_NAME, API_VERSION, credentials=credentials)
    request = youtube.videos().rate(id=_id, rating="like")
    request.execute()


def main(args):
    credentials = _load_credentials()

    if not credentials or not credentials.valid:
        expired = _is_access_token_expired(credentials)
        if expired:
            credentials = _get_new_access_token()

    _id = args[1].split("?v=")[1]
    _like_video(credentials, _id)

    print("\n>>> Liked Successfully <<<")

if __name__ == "__main__":
    main(sys.argv)
    sys.exit(0)
