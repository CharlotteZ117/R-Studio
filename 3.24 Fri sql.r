# Week 8, Friday, March 24, 2023
#-----------------------------------

# install.packages("sqldf")
library(sqldf)

code <- read.csv("Code.csv")
edu <- read.csv("Education.csv")

sqldf("select * from edu")    # reads the data file edu

# Reads only two variables
sqldf("select Country, Rank_Edu from edu")

# Reads the first 10 records
sqldf("select Country, Rank_Edu from edu LIMIT 10")

# Counts the totals rows
sqldf("select count(*) from edu")

sqldf("select * from edu where MATHS>500")

sqldf("select * from edu where MATHS>500 group by Rank_edu")

# Show the countries which ranked between 1 and 5.
sqldf("select * from edu where Rank_edu<6")
sqldf("select * from edu where Rank_edu between 1 and 5")
sqldf("select * from edu where Rank_edu in (1,2,3,4,5)")
sqldf("select * from edu where Rank_edu in (1,10,30)")

# Sorting the data from smallest to largest
sqldf("select * from edu where Rank_edu<6 order by Reading")
sqldf("select * from edu where Rank_edu<6 order by Reading ASC")

# Sorting the data from largest to smallest
sqldf("select * from edu where Rank_edu<6 order by Reading DESC")



sqldf("select * from edu where Reading LIKE '%9' ")
sqldf("select * from edu where Reading LIKE '4%' ")

# Creating a new variable
sqldf("select Reading, Maths, Science,
      (Reading+Maths+Science)/3 as AVG3 from edu ")

sqldf("select Reading, Maths, Science, Rank_edu,
      (Reading+Maths+Science)/3 as AVG3 from edu group by Rank_edu")

# Reading code data file
sqldf("select * from code LIMIT 5")

# Show Country Rank_Edu, Population and Area, which are common
# between two files 

common <- sqldf("select edu.Country, edu.Rank_edu, code.country,code.Population,
      code.Area from code INNER JOIN edu on
      code.country=edu.country")
head(common)
names(common)

sqldf("select edu.Country, edu.Rank_edu, code.country,code.Population,
      code.Area from code FULL JOIN edu on
      code.country=edu.country")
nrow(edu)
nrow(code)


x <-sqldf("select edu.Country, edu.Rank_edu, code.country,code.Population,
      code.Area from code LEFT JOIN edu on
      code.country=edu.country")
nrow(x)

x <-sqldf("select edu.Country, edu.Rank_edu, code.country,code.Population,
      code.Area from code RIGHT JOIN edu on
      code.country=edu.country")
nrow(x)


x <-sqldf("select edu.Country, edu.Rank_edu, code.country,code.Population,
      code.Area from edu LEFT JOIN code on
      code.country=edu.country")
nrow(x)
