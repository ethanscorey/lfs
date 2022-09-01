import csv
import re
import sys


print("Creating package CSV")
url_file = sys.argv[1]
md5sums_file = sys.argv[2]

rows = []
md5sums = []

with open(url_file) as f:
    reader = csv.reader(f)
    for row in reader:
        rows.append(row)

with open(md5sums_file) as f:
    reader = csv.reader(f)
    for row in reader:
        md5sums.append(row)


with open("packages.csv", "w") as pkg_file:
    pkg_writer = csv.writer(pkg_file)
    for url, md5sum_row in zip(rows, md5sums):
        url = url[0]
        md5sum, fname = re.split(r"\s+", md5sum_row[0])
        pkg_writer.writerow([fname, url, md5sum])
