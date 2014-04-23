
# New version is more generalized to look at the file names on the ftp site and pull down the file, whatever it is called.  This deals with some of the finicky differences in file names mostly relating to the years (start/stop) and whether the GCM model name is listed in capital letters.

setInternet2(TRUE)

extract.name <- function(x, position) { return(unlist(strsplit(x,'"'))[position]) }

save.ftp.file <- function(ftp.address, out.dir, position) # variables, years, 
{
	download.file(ftp.address, 'temp.file.names.txt')
	temp <- readLines('temp.file.names.txt')
	# print(temp); stop('cbw')
	file.names <- temp[grep('update.obs.monthly', temp, ignore.case=TRUE)] # 'A HREF=\"'
	# print(file.names)
	# print(unlist(strsplit(file.names[1], '"'))); stop('cbw')
	file.names <- sapply(file.names, extract.name, simplify=TRUE, USE.NAMES=FALSE, position) # as.character(strsplit(file.names, '"'))
	temp <- data.frame(files=paste(ftp.address, file.names, sep=''),out=paste(out.dir, file.names, sep=''))
	d.file <- function(x) { download.file(x[1],x[2]) }
	apply(temp, 1, d.file)
	# ifelse(file.exists(output.file),return(),download.file(file.address,output.file))
}

save.ftp.file(
	ftp.address='http://hydro.engr.scu.edu/files/gridded_obs/monthly/ncfiles_2010/', 
	out.dir='d:/ClimateData/Maurer2010Historical/', 
	# variables=c('pr','tas','tasmax','tasmin'), # ,'wind',), 
	# years=seq(1992,2010,1),
	position=8
	)
stop('cbw')

