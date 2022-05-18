require 'nokogiri'
require 'httparty'
require 'byebug'

#all scraper functionality
def scraper
    url = "https://libguides.scu.edu/c.php?g=175638&p=1157151"      #ANTH 02
    #url = "https://libguides.scu.edu/c.php?g=994437&p=7195646"     #HIST 177
    #url = "https://libguides.scu.edu/c.php?g=904144&p=6507895"     #CPSY 220

    unparsed_page = HTTParty.get(url)                               #gets raw HTML of the given URL
    parsed_page = Nokogiri::HTML(unparsed_page)                     #useful for extracting data in nicer format
    booklist = parsed_page.css('div.s-lg-book-props')               #list of books (finding specific HTML style class found on the page)
    infos = Array.new                                               #stores book information in an array

    for book in booklist
        info = {                                                    #gathers information on books in library page (elements in the larger style class)
            title: book.css('span.s-lg-book-title').text,
            author: book.css('span.s-lg-book-author').text,
            isbn: book.css('div.s-lg-book-prop-isbn').text,
            publish: book.css('div.s-lg-book-prop-pubdate').text
        }
        infos << info
        puts "Found #{info[:title]}"
    end

    puts ("Number of books found: " + (booklist.count).to_s)        #returns number of listed books

    byebug                                                          #a debugger used to interact w/ the listed variables
end

scraper