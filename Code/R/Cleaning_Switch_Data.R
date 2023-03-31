install.packages('tidyverse')
install.packages('skimr')#summarizing data / skimming data
install.packages('janitor') #cleaning data

library('tidyverse')
library('skimr')
library('janitor')
library(ggplot2)


#Obtain the dataset
switch_sales <- read_csv('best_selling_switch_games.csv')


#Check the column names
colnames(switch_sales)
#Obtain info on its structure, columns, etc.
str(switch_sales)

glimpse(switch_sales)
skim_without_charts(switch_sales)

#Ensure the columns have valid characters(underscores, numbers, and characters)
clean_names(switch_sales)

#Selected the columns needed, while also renaming it into Proper Case
switch_sales_selected <- switch_sales %>% 
  select(Title = title, Copies_Sold = copies_sold, Genre = genre, Release_Date = release_date, Ip = IP)

# Created a new column to limit the numbers for copies sold, and round to 1 decimal place
# Drop the old Copies_Sold Column
switch_sales_sold <- switch_sales_selected %>% 
  mutate(Units_Sold_Mill = round(Copies_Sold * 10^-6,1)) %>% 
  select(-Copies_Sold)



#Fixing the genre column by properly splitting the different genres

switch_sales_sold$Genre[switch_sales_sold$Genre == "Hack and slashRole-playing"] = 'Hack and slash, Role-playing'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Kart racingaugmented reality"] = 'Kart racing, Augmented reality'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Exergamerole-playing"] = 'Exergame, Role-playing'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Sandboxsurvival"] = 'Sandbox, Survival'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Real-time strategypuzzle"] = 'Real-time, Strategy Puzzle'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Platformercompilation"] = 'Platformer, Compilation'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Simulationrole-playing"] = 'Simulation, Role-playing'
switch_sales_sold$Genre[switch_sales_sold$Genre == "PlatformerLevel editor"] = 'Platformer, Level editor'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Role-playingaction-adventure"] = 'Role-playing, Action-adventure'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Partysocial deduction"] = 'Party, Social deduction'
switch_sales_sold$Genre[switch_sales_sold$Genre == "Exergamerhythm"] = 'Exergame, Rhythm'



#Check if the values are correct
unique(switch_sales_sold$Genre)


#See how much of each genre there are
grouped_genre <- switch_sales_sold %>% 
  group_by(Genre) %>% 
  summarize(count = n()) 
#sort by count

grouped_genre <- grouped_genre[order(grouped_genre$count,decreasing =  TRUE),]

# Look at the most popular 7 genres
top_genres <-head(grouped_genre,7)



#Add a column where the year is extracted
year_added <- switch_sales_sold %>% 
  mutate(year = format(switch_sales_sold$Release_Date,'%Y'))

#Group by the year 
#Also perform calculations on each year
grouped_year <- year_added %>% 
  group_by(year) %>% 
  summarize(num_of_titles = n(), total_sales = sum(Units_Sold_Mill),
            min_sales = min(Units_Sold_Mill), max_sales = max(Units_Sold_Mill),
            average_sales = mean(Units_Sold_Mill))



############################################################
#Switch Genre Bar graph
min_date = min(switch_sales$release_date)
max_date = max(switch_sales$release_date)


ggplot(data = top_genres, aes(x  =reorder(Genre,-count), y = count)) +
  geom_bar(stat= 'identity',mapping = aes(fill= Genre)) +
  labs(title = 'Top 7 Switch Genres', subtitle = 'Amount of Games with Over 1 Million Copies Sold',
       y = "Number of Games",
       x = "Genre",
       caption = paste0("Switch Games From: ", min_date, " to ", max_date)) +
  theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
        legend.position = 'None',        
        panel.background = element_rect(fill="#ebf2ff"),
        legend.background = element_rect(fill="#ebf2ff"),
        plot.background = element_rect(fill="#ebf2ff")) +
  geom_text(aes(label = count, fontface= 'bold'),vjust = 1)



############################################################

# Year Pie Chart

ggplot(data = grouped_year,aes(x = "",y = num_of_titles, fill = year)) +
  geom_bar(stat = 'identity', color = 'black') +
  geom_text(aes(x = 1.7,label = year), 
            position = position_stack(vjust = 0.5)) +
  geom_text(aes(label = num_of_titles), 
            position = position_stack(vjust = 0.5)) +
  coord_polar(theta = 'y') +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position= 'None',
        panel.background = element_rect(fill=("#ebf2ff")),
        legend.background = element_rect(fill="#ebf2ff"),
        plot.background = element_rect(fill="#ebf2ff"),
        plot.caption.position = 'plot') +
  labs(title = "Amount of Switch Games Selling Over 1 Million", subtitle='Split By Year',
       caption = paste0("Switch Games From: ", min_date, " to ", max_date)) 


##############################################################

grouped_year_ip <- year_added %>% 
  group_by(year,Ip) %>% 
  summarize(Units_Sold_Year = sum(Units_Sold_Mill), Avg_Sales = mean(Units_Sold_Mill))

# Stacked Bar Graph

ggplot(data = grouped_year_ip, aes(x = year, y = Units_Sold_Year)) +
  geom_bar(stat = 'identity', aes(fill = Ip)) +
  labs(title = "Switch Game Sales By Year",
       subtitle = "Split By Nintendo Properties",
       y = "Total Game Sales") +
  theme(panel.background = element_rect(fill ='#BFDEDF',),
        legend.background = element_rect(fill ='#BFDEDF'),
        plot.background = element_rect(fill ='#BFDEDF'))



##############################################################
# Line Graph IP's yearly sales

ggplot(data = grouped_year_ip) +
  geom_point(aes(x = year, y = Units_Sold_Year)) +
  geom_line(aes(x = year, y = Units_Sold_Year, group = Ip, color = Ip)) +
  facet_wrap(~Ip,scales = 'free') +
  scale_y_continuous(limits= c(0,75))+
  labs(title = "Yearly Sales For Nintendo Properties",
       subtitle = "2017- 2019",y = "Sales (Millions)") +
  theme(plot.background = element_rect(fill ='#BFDEDF'), 
        legend.background = element_rect(fill ='#BFDEDF'),
        legend.position = 'None')















