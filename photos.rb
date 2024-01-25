require "csv"
def solution(s)
    # break up input string
    photos = CSV.parse(s)
    i = 1
    photos.each do |p|
        # add the original order to each array
        p.push(i)
        i = i + 1
    end
    # sort by city and date/time
    sorted_photos = photos.sort_by { |el| [el[1], el[2]] }
    current_city = sorted_photos[0,1]
    city_array = []
    new_name_array = []
    sorted_photos.each do |p|
        if p[1] != current_city
            # new city, process the data 
            new_name_array = new_name_array + process_current_city(city_array)
            city_array = []
            current_city = p[1]
        end
        # store the data for the city
        city_array.push(p)
    end
    new_name_array = new_name_array + process_current_city(city_array)
    sorted_solution = new_name_array.sort_by { |el| el[1] }
    photo_list = ''
    sorted_solution.each do |s|
        photo_name = s[0].strip
        photo_list = photo_list << photo_name << "\n"
    end
    photo_list

end

def process_current_city(city_array)
    case city_array.length
    when 1..9
        n = 1
    when 10..99
        n = 2
    else
        n = 3
    end

    new_name_array = []
    j = 1
    city_array.each do |c|
        # create new_name_array for each photo for the previous city
        photo_parts = c[0].split(".")
        photo_suffix = photo_parts[1]
        photo_number = j.to_s.rjust(n, "0")
        new_name = c[1] << photo_number << "." << photo_suffix
        new_name_array.push([new_name, c[3]])
        j = j + 1
    end
    new_name_array
end

test_string = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"
puts "#{solution(test_string)}"
