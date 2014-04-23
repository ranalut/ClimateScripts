
variables <- c('ppt','tmin','tmax','tmean')
years <- seq(1992,2005,1)
months <- c('01','02','03','04','05','06','07','08','09','10','11','12')
out.dir <- 'd:/climatedata/prism/'
path.names <- NA
file.names <- NA
for (i in variables)
{
	for (j in years)
	{
		for (k in months)
		{
			path.names <- c(path.names, paste('http://services.nacse.org/prism/data/public/4km/',i,'/',j,k,sep=''))
			file.names <- c(file.names,paste('prism_',i,'_stable_4kmM2_',j,k,'_bil.zip',sep=''))
		}
	}
}

path.names <- path.names[-1]
file.names <- file.names[-1]
# print(head(path.names)); stop('cbw')

temp <- data.frame(files=path.names,out=paste(out.dir, file.names, sep=''))

d.file <- function(x) { download.file(x[1],x[2]) }
# apply(temp[1,], 1, d.file)
apply(temp, 1, d.file)

