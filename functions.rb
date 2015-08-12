require 'readline'
require 'date'


#The earliest start date for which there is valid data
DATA_START_DATE = '2006-09-20'

#We want to limit queries to the remote server. This is the maximum number of days that can be retrieved.   For each day, we make three (3) queries, one for each type of reading.
MAX_DAYS = 7

READING_TYPES = {
  "Wind_Speed" => "Wind Speed",
  "Air_Temp" => "Air Temp",
  "Barometric_Press" => "Pressure"
}

#Ask the user (via the command line) to provide valid start and end date
def query_user_for_data_range
end

#Test if a single date is valid
def date_valid?(date)
  valid_dates = Date.parse(DATA_START_DATE)..Date.today
  if valid_dates.cover?(date)
    return true
  else
    puts "\nDate must be after #{DATA_START_DATE} and before today."
    return false
  end
end

#Test if range of dates is valid
def date_range_valid?(start_date, end_date)
  if start_date > end_date
    puts "\nStart date must be before end date."
    return false
  elsif start_date + MAX_DAYS < end_date
    puts "\nNo more than #{MAX_DAYS} days. Be kind to the remote server please."
    return false
  else
    return true
  end
end

# Ask the user (via the command line) to provide valid start and end dates.
def query_user_for_date_range
  start_date = nil
  end_date = nil

  until start_date && end_date
    puts "\nFirst, we need a start date."
    start_date = query_user_for_date

    puts "\nNext, we need an end date."
    end_date = query_user_for_date

    if !date_range_valid?(start_date,end_date)
      puts "Let's try again."
      start_date = end_date = nil
    end
  end

  return start_date, end_date
end

# Ask the user (via the command line) for a single valid date. 
# Used for both start and end dates.
def query_user_for_date
  date = nil
  until date.is_a? Date
    prompt = "Please enter a date as YYYY-MM-DD: "
    response = Readline.readline(prompt, true)
    
    # We have the option to quit at any time.
    exit if ['quit', 'exit', 'q', 'x'].include?(response)

    begin
      date = Date.parse(response)
    rescue ArgumentError
      puts "\nInvalid date format."
    end

    date = nil unless date_valid?(date)
    
  end
  return date
end
