def convert_to_24_hour(input_time):
  
    if len(input_time) <= 4:
        input_time = input_time[:-2] + ":00" + input_time[-2:]
    time, period = input_time[:-2], input_time[-2:]
    hours, minutes = map(int, time.split(':'))
    if period == "pm" and hours != 12:
        hours += 12
    elif period == "am" and hours == 12:
        hours = 0
    return f"{hours:02}:{minutes:02}"

input_time = input("Enter time : ")
print(convert_to_24_hour(input_time))