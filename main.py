#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json


def csv_to_json(fname):
    i     = 0
    keys  = None
    store = []
    with open('src/csv/'+fname+'.csv') as f:
        for line in f:
            data = line.split('","')[1:-2]
            if i == 0:
                keys = [k for k in data]
            else:
                d = {}
                for j in range(0, len(keys)):
                    d[keys[j]] = data[j]
                store += [d]
            i += 1
    with open('var/json/'+fname+'.json', 'w') as f:
        f.write(json.dumps(store, sort_keys=True, indent=4))
    return store

def main():
    print csv_to_json('root')
    print csv_to_json('plus')

if __name__ == "__main__":
    main()
