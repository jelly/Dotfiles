#!/usr/bin/python

'''
Usage:

USERS="@userb:@userc" python tiktok2rss.py
'''

import os
import re
import sys
from datetime import datetime, timedelta, timezone

from feedgen.feed import FeedGenerator
from playwright.sync_api import sync_playwright

FEED_BASE_URL = 'https://dodgy.download/tiktok-{}.xml'


def convert_datestr(datestr):
    now = datetime.now()
    match = re.match(r'(\d+)h ago', datestr)
    if match:
        hours = int(match.group(1))
        return now - timedelta(hours=hours)

    match = re.match(r'(\d+) days ago', datestr)
    if match:
        days = int(match.group(1))
        return now - timedelta(days=days)

    return datetime.strptime(datestr, '%Y-%m-%d')


def create_feed(username, url, desc):
    fg = FeedGenerator()
    fg.id(FEED_BASE_URL.format(username))
    fg.title(f'Tik Tok ({username}')
    fg.description(desc)
    fg.link(href=url, rel='alternate')
    fg.language('en')
    return fg


def main():
    users = os.getenv('USERS')
    if not users:
        print('error, no users')
        sys.exit(1)

    users = users.split(':')

    with sync_playwright() as p:
        browser = p.chromium.launch(executable_path='/usr/bin/chromium')
        page = browser.new_page()

        for user in users:
            url = f'https://tiktok.com/{user}?lang=en'
            page.goto(url)
            desc = page.query_selector('h2[data-e2e="user-bio"]').inner_text()

            username = user.replace('@', '')
            fg = create_feed(username, url, desc)

            videos = [v.get_attribute('href') for v in page.query_selector_all('div[data-e2e="user-post-item-list"] div[data-e2e="user-post-item"] a')]
            titles = [v.get_attribute('title') for v in page.query_selector_all('div[data-e2e="user-post-item-list"] div[data-e2e="user-post-item-desc"] a:first-of-type')]
            titles = [t for t in titles if t is not None]
            for index, video in enumerate(videos):
                title = titles[index]
                page.goto(video)

                pubdate = convert_datestr(page.query_selector('span[data-e2e="browser-nickname"] span:last-of-type').inner_text())
                pubdate = pubdate.replace(tzinfo=timezone.utc)
                fe = fg.add_entry()
                fe.id(video)
                fe.title(title)
                fe.description(title)
                fe.link(href=video)
                fe.pubDate(pubdate)

            fg.rss_file(f'tiktok-{username}.xml')

        browser.close()


if __name__ == "__main__":
    main()
