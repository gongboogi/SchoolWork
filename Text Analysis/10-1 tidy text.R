## 텍스트 분석 10-1 tidy text

text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

source <- c("BBC", "FOX", "CNN")

library(dplyr)
#dplyr에 들어있는 tibble(): 직관적 표현
text.df <- tibble(source = source, text = text) # 두 벡터로 tibble데이터 만듦
text.df
class(text.df)
#문자데이터 -> 데이터프레임: 팩터, 티블: 팩터변환x


#tokenization
library(tidytext)
unnest_tokens(tbl = text.df, output = word , input = text) 
text.df %>%
  unnest_tokens(output = word, input = text)
head(iris)

tidy.docs <- text.df %>%
  unnest_tokens(output = word, input = text)

print(tidy.docs) #n=10, n=inf ...


tidy.docs %>% count(source) %>%
  arrange(desc(n)) #source개수를 세고 내림차순으로 정렬


# 불필요한 단어 제거
?anti_join() #innerjoin

stop_words #불용어 

anti_join(tidy.docs, stop_words, by = "word")

tidy.docs <- tidy.docs %>% anti_join(stop_words, by= "word")

word.removed <- tibble(word = c("http", "bbc", "in", "1g0j4agg"))

tidy.docs <- tidy.docs %>% anti_join(word.removed, by= "word")
tidy.docs


tidy.docs$word


#숫자 제거
grep("\\d+", tidy.docs$word)

tidy.docs <- tidy.docs[-grep("\\d+", tidy.docs$word),]
tidy.docs

text.df$text <- gsub("(f|gf)tp\\S+\\s/*", "", text.df$text)
text.df$text

text.df$text <- gsub("\\d+", "", text.df$text)

tidy.docs <- tidy.docs <- text.df %>%
  unnest_tokens(output = word, input = text)
tidy.docs


tidy.docs <- tidy.docs %>% anti_join(stop_words, by = "word")

tidy.docs$word <- gsub("ian", "", tidy.docs $ word)
tidy.docs$word <- gsub("economists", "economy", tidy.docs $ word)


library(tm)
corpus.docs <- VCorpus(VectorSource(text))
meta(corpus.docs, tag = "author", tpye = "local") <- source
lapply(corpus.docs, meta)

tidy(corpus.docs) %>% unnest_tokens(word, text) %>% select(source=author, word)

