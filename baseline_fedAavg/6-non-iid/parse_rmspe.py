import re

input_file_path = "res.txt"
output_file_path = "parsed_data.txt"


def parse_line_info(line):
    # Use regex to find the number after 'round' and the number after ':'
    round_number = re.search(r'round(\d+)', line).group(1)
    rmspe_value = re.search(r':\s*([\d.]+)', line).group(1)
    
    return round_number, rmspe_value

round_numbers = []
rmspe_values = []

with open(input_file_path, 'r') as file:
    for line in file:
        #print(line)

        if 'FedAVG (server)' in line:
            
            round_number ,rmspe_value = parse_line_info(line)

            round_numbers.append(round_number)
            rmspe_values.append(rmspe_value)


with open(output_file_path, 'w') as file:
    file.write("Round Numbers:\n")
    file.write(', '.join(round_numbers) + '\n')
    file.write("RMSPE Values:\n")
    file.write(', '.join(rmspe_values) + '\n')

print("foi")