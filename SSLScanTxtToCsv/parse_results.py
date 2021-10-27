import csv

def parse():
    with open('results.txt', 'r') as f:
        with open('parsed.csv', 'w', newline='') as csvfile:
            fields = ['IP','SSLv2','SSLv3','TLSv1.0','TLSv1.1','TLSv1.2','TLSv1.3']
            writer = csv.writer(csvfile)
            writer.writerow(fields)


            lines = f.readlines()
            row = []
            for line in lines:
                if "Connected to" in line:
                    row.append(str(line.split(' ')[2].strip('\n')))
                if line.lower().startswith(('sslv2', 'sslv3','tlsv1.0','tlsv1.1','tlsv1.2','tlsv1.3')) and any(state in line.lower() for state in ['enabled', 'disabled']):
                    row.append(str(''.join(line.split()[1])))
                    if(line.lower().startswith('tlsv1.3') and any(state in line.lower() for state in ['enabled', 'disabled'])):
                        writer.writerow(row)
                        row = []
            csvfile.close()
        f.close()


parse()
