## 텍스트 분석 11-2 DTM


text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

library(tm)

#텍스트 전처리
corpus.docs <- VCorpus(VectorSource(text))
lapply(corpus.docs, meta)
lapply(corpus.docs, content)
corpus.docs <- tm_map(corpus.docs, content_transformer(tolower)) #소문자 변환
corpus.docs <- tm_map(corpus.docs, removeWords, stopwords("english")) #불용어 제거
myRemoves <- content_transformer(function(x, pattern)
{return(gsub(pattern, "", x))}) #특정 패턴을 가지는 문자열 제거

corpus.docs <- tm_map(corpus.docs, myRemoves, "(f|ht)tp\\S+\\s*") #url제거
corpus.docs <- tm_map(corpus.docs,removePunctuation) #문장부호 삭제

lapply(corpus.docs, content)
corpus.docs[[1]]$content


# 숫자 제거
corpus.docs <- tm_map(corpus.docs,removeNumbers)
lapply(corpus.docs, content)

# 공백 제거
corpus.docs <- tm_map(corpus.docs,stripWhitespace)
lapply(corpus.docs, content)

corpus.docs <- tm_map(corpus.docs, content_transformer(trimws))
lapply(corpus.docs, content)

# 어간, 어미 추출

corpus.docs <- tm_map(corpus.docs, stemDocument)
lapply(corpus.docs, content)


# 유의어 통합
corpus.docs <- tm_map(corpus.docs, content_transformer(gsub),
                      pattern="economist", replacement = "economi")
lapply(corpus.docs, content)



?DocumentTermMatrix

DocumentTermMatrix(corpus.docs,
                   control = list(wordLengths = c(2,Inf)))
corpus.dtm <- DocumentTermMatrix(corpus.docs,
                                 control = list(wordLengths = c(2,Inf)))

nTerms(corpus.dtm)
nDocs(corpus.dtm)
Terms(corpus.dtm)

Docs(corpus.dtm)
row.names(corpus.dtm) <- c("BBC", "CNN", "Fox")

inspect(corpus.dtm)
inspect(corpus.dtm[1:3,10:19])








text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

source <- c("BBC", "FOX", "CNN")

library(dplyr)
library(tidytext)
library(SnowballC)

text.df <- tibble(source = source, text = text) # 두 벡터로 tibble데이터 만듦
text.df




text.df$text <- gsub("(f|gf)tp\\S+\\s/*", "", text.df$text)
text.df$text

text.df$text <- gsub("\\d+", "", text.df$text) #숫자 삭제


tidy.docs <- tidy.docs <- text.df %>%
  unnest_tokens(output = word, input = text)
tidy.docs


tidy.docs <- tidy.docs %>% anti_join(stop_words, by = "word")
tidy.docs <- tidy.docs %>% mutate(word=wordStem(word)) #어간 추출

tidy.docs$word <- gsub("\\s+", "", tidy.docs$word) #공백제거
tidy.docs$word <- gsub("economist", "economi", tidy.docs$word) #동의어처리
tidy.docs


tidy.docs %>% count(source, word) %>%
  cast_dtm(document = source, term = word, value = n)

tidy.dtm <- 
  tidy.docs %>% count(source, word) %>%
  cast_dtm(document = source, term = word, value = n)

tidy.dtm
Terms(tidy.dtm)
Docs(tidy.dtm)
inspect(tidy.dtm[1:2, 3:5])
