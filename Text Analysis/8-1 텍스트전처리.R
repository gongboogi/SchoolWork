## 텍스트 분석 8-1 텍스트전처리


file=file.choose()
#readLines: 텍스트를 줄 별로 읽는다.
raw_moon <- readLines(file, encoding = "UTF-8")


txt <- "치킨은!! 맛있다. xyz 정말 맛있다  !@#"
txt

library(stringr)
str_replace_all(txt, "[^가-힣]", replacement = " ") 
# -> 가-힣: 모든 한글. ^가-힣: 한글이 아닌 것


# 한글이 아닌 문자를 공백으로
moon <- raw_moon %>% str_replace_all("[^가-힣]", " ")
head(moon)

#str_squish(): 공백 없애기. 앞뒤 공백뿐만 아니라 중간 공백도 하나의 공백으로
moon <- str_squish(moon)
head(moon)


library(dplyr)
#as_tibble(): 내용을 직관적으로 변환해준다.
moon <- as_tibble(moon)
moon 


### 토큰화 하기 ###
## tidytext, unnest_token() 함수 활용

install.packages("tidytext")
library(tidytext)

text <- tibble(value = "대한민국은 민주공화국이다. 대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다.")

# 토큰화: 기준을 정해 텍스트를 나눈다.
text %>% unnest_tokens(input = value, output = word,
                       token = "sentences") #문장을 기준으로.

text %>% unnest_tokens(input = value, output = word,
                       token = "words") #공백(단어)을 기준으로.

text %>% unnest_tokens(input = value, output = word,
                       token = "characters") #글자를 기준으로.


moon_space <- moon %>% unnest_tokens(input = value, output = word,
                                     token = "words") #공백(단어)을 기준으로.
moon_space


### 단어 빈도 분석 하기 ###
moon_space <- moon_space %>% count(word, sort = T)
moon_space

# str_count(): 텍스트길이
str_count('배')
str_count('배배배')

# 한 글자 단어 제외하기
moon_space <- moon_space %>% filter(str_count(word) > 1)
moon_space

#빈도 높은 단어 20개
top20_moon <- moon_space %>% head(20)
top20_moon


#ggplot2
library(ggplot2)

ggplot(top20_moon, aes(x= reorder(word, n), y = n)) + #단어 빈도순 정렬
  geom_col() + #bar차트
  coord_flip() #축 뒤집기


### 워드 클라우드 ###
install.packages("ggwordcloud")
library(ggwordcloud)

ggplot(moon_space, aes(label = word, size = n)) +
  geom_text_wordcloud(seed = 1234) + #여러 번 실행 시 동일한 결과
  scale_radius(limits = c(3, NA),
               range = c(3,30)) #최소, 최대 단어 빈도와 글자 크기 지정


