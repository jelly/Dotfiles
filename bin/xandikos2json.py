#!/usr/bin/python

import json
from datetime import datetime, timedelta, timezone
from glob import glob

from dateutil.rrule import rrulestr
from icalendar import Calendar

DAYS_AHEAD = 30


def main():
    events = []
    now = datetime.now(timezone.utc) - timedelta(days=1)
    future = now + timedelta(days=DAYS_AHEAD)
    for event in glob('*.ics'):
        with open(event, 'r') as fp:
            cal = Calendar.from_ical(fp.read())
            for component in cal.walk():
                if component.name != "VEVENT":
                    continue

                rrule = None
                start = component.decoded("dtstart")
                startdate = start
                end = component.decoded("dtend")
                enddate = end
                if isinstance(start, datetime):
                    startdate = start.date()
                if isinstance(end, datetime):
                    enddate = end.date()
                if component.get('rrule'):
                    try:
                        rules = component.get('rrule')
                        if not isinstance(rules, list):
                            rules = [rules]

                        for rule in rules:
                            rule = rule.to_ical().decode()
                            rrule = rrulestr(rule, dtstart=start)
                            for occur in rrule.between(now.replace(tzinfo=None), future.replace(tzinfo=None)):
                                events.append({
                                    'start': occur.isoformat(),
                                    'end': occur.isoformat(),
                                    'title': str(component.get('summary')),
                                })
                    except Exception as e:
                        print("exc", e, component.get('rrule'))

                if startdate > now.date() and enddate < future.date():
                    events.append({
                        'start': start.isoformat(),
                        'end': start.isoformat(),
                        'title': str(component.get('summary')),
                    })

    open('calendar.json', 'w').write(json.dumps(events, indent=4))


if __name__ == "__main__":
    main()
