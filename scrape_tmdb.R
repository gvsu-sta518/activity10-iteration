# This function scrapes the following information from TMDB
#    - title
#    - year
#    - rating
#    - TMDB score

scrape_tmdb <- function(url){
  
  page <- read_html(url)
  
  # Scrape show tile
  title <- page %>% 
    html_element("h2 a") %>% 
    html_text()
  
  # Scrape show year
  year <- page %>% 
    html_element("h2 span") %>% 
    html_text() %>% 
    str_extract(pattern = "[0-9]+") %>% 
    as.numeric()
  
  # Scrap show rating
  rating <- page %>% 
    html_element("span.certification") %>% 
    html_text() %>% 
    str_trim(side = "both")
  
  # Scrape TMDB score
  score <- page %>% 
    html_element("div.user_score_chart") %>% 
    html_attr("data-percent") %>% 
    as.numeric()
  
  # Output a tibble with one row that contains the above scraped information
  tibble(
    title = title,
    year = year,
    rating = rating,
    score = score
  )
  
}