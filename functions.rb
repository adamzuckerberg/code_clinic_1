require 'readline'
require 'date'

#The earliest start date for which there is valid data
DATA_START_DATE = '2006-09-20'

#We want to limit queries to the remote server. This is the maximum number of days that can be retrieved.   For each day, we make three (3) queries, one for each type of reading.
MAX_DAYS = 7

# Ask the user (via the command line) to provide valid start and end dates.
def query_user_for_date_range
  start_date = nil
  end_date = nil

  puts "\nFirst, we need a start date."
  start_date = query_user_for_date

  puts "\nNext, we need an end date."
  end_date = query_user_for_date

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
    
  end
  return date
end
