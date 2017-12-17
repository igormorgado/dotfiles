# Options to control saving to disk

### Begin group: DEFAULT
 
# update metadata
# Normally, calibre will update the metadata in the saved files from what is in the calibre library. Makes saving to disk slower.
update_metadata = False
 
# write opf
# Normally, calibre will write the metadata into a separate OPF file along with the actual e-book files.
write_opf = False
 
# save cover
# Normally, calibre will save the cover in a separate file along with the actual e-book files.
save_cover = False
 
# formats
# Comma separated list of formats to save for each book. By default all available formats are saved.
formats = 'all'
 
# template
# The template to control the filename and directory structure of the saved files. Default is "{author_sort}/{title}/{title} - {authors}" which will save books into a per-author subdirectory with filenames containing title and author. Available controls are: {author_sort, authors, id, isbn, languages, last_modified, pubdate, publisher, rating, series, series_index, tags, timestamp, title}
template = u'{author_sort}/{title}/{author_sort:lastname()}{pubdate:format_date(yyyy)}-{title}'
 
# send template
# The template to control the filename and directory structure of files sent to the device. Default is "{author_sort}/{title} - {authors}" which will save books into a per-author directory with filenames containing title and author. Available controls are: {publisher, series_index, isbn, pubdate, rating, series, author_sort, languages, authors, last_modified, timestamp, title, id, tags}
send_template = '{author_sort}/{title} - {authors}'
 
# asciiize
# Normally, calibre will convert all non English characters into English equivalents for the file names. WARNING: If you turn this off, you may experience errors when saving, depending on how well the filesystem you are saving to supports unicode.
asciiize = True
 
# timefmt
# The format in which to display dates. %d - day, %b - month, %m - month number, %Y - year. Default is: %b, %Y
timefmt = '%b, %Y'
 
# send timefmt
# The format in which to display dates. %d - day, %b - month, %m - month number, %Y - year. Default is: %b, %Y
send_timefmt = '%b, %Y'
 
# to lowercase
# Convert paths to lowercase.
to_lowercase = False
 
# replace whitespace
# Replace whitespace with underscores.
replace_whitespace = False
 
# single dir
# Save into a single directory, ignoring the template directory structure
single_dir = False
 


