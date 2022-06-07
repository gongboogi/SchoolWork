## 텍스트 분석 13-1 TF-IDF

# 12주차 리뷰
library(quanteda)
library(tidytext)
library(tibble)
library(dplyr)

data_corpus_inaugural

#tibble형태로 변환

us.president.address <- tidy(data_corpus_inaugural) %>%
  filter(Year > 1990) %>%
  group_by(President, FirstName) %>%
  summarise_all(list(~trimws(paste(., collapse = " ")))) %>% #
  arrange(Year) %>%
  ungroup() #group 해제

us.president.address


library(tm)
?DataframeSource

#doc_id가 필요함.
us.president.address <- us.president.address %>%
  select(text, everything()) %>%
  add_column(doc_id = 1:nrow(.), .before = 1)

us.president.address

# corpus로 만듦
address.corpus <- VCorpus(DataframeSource(us.president.address))

lapply(address.corpus[1], content)


#전처리
# tolower() <- tm패키지에서 쓸 수 없음
address.corpus <- tm_map(address.corpus, content_transformer(tolower))
address.corpus[[1]]$content

#불용어
sort(stopwords("english"))

#불용어 사전 만들기
Mystopwords <- c(stopwords("english"), c("must", "will", "can", "bless", "america"))

address.corpus <- tm_map(address.corpus, removeWords, Mystopwords)

address.corpus[[1]]$content


#구두점 처리
address.corpus <- tm_map(address.corpus, removePunctuation)
lapply(address.corpus[1], content)

# 숫자, 공백 제거
address.corpus <- tm_map(address.corpus, removeNumbers)
address.corpus <- tm_map(address.corpus, stripWhitespace)
address.corpus <- tm_map(address.corpus, content_transformer(trimws))
lapply(address.corpus[1], content)


address.corpus <- tm_map(address.corpus, content_transformer(gsub),
                         pattern = "america|american|americans|america",
                         replacement = "america")
lapply(address.corpus[1], content)





#DTM
address.dtm <- DocumentTermMatrix(address.corpus)
inspect(address.dtm)
as.matrix(address.dtm)
termfreq <- colSums(as.matrix(address.dtm)) #개별 termfreq

length(termfreq)


termfreq[head(order(termfreq, decreasing = TRUE),10)]
termfreq[tail(order(termfreq, decreasing = TRUE),10)]


findFreqTerms(address.dtm, lowfreq = 40) #최소 40번 이상 등장한 단어
findFreqTerms(address.dtm, lowfreq = 50, highfreq=80) #50~80번 등장한 단어






library(ggplot2)
class(termfreq)

termfreq.df <- data.frame(word = names(termfreq), frequency = termfreq) 
head(termfreq)

ggplot(subset(termfreq.df, frequency >= 40),
       aes(x=word, y=frequency, fill = word)) +
  geom_col(color="dimgray") +
  labs(x=NULL, y = "Term Frequency (count)")


ggplot(subset(termfreq.df, frequency >= 40),
       aes(x = reorder(word, frequency), y = frequency, fill=word)) +
  geom_col(color = "dimgray", width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = frequency), size = 3.5, color = "black", hjust = 0)+
  labs(x=NULL, y ="Term Frequency (count)") +
  coord_flip() #x축과 y축 바꾸기




#id에 대통령 이름 넣기
Docs(address.dtm)
row.names(address.dtm) <- c("Clinton", "Bush", "Obama", "Trump", "Biden")
Docs(address.dtm)

# 워드 클라우드
set.seed(123)

install.packages("wordcloud")
library(wordcloud)
head(termfreq)
wordcloud(words = names(termfreq), freq = termfreq,
          scale = c(4,0,5), min.freq = 10,
          rot.per = 0.1, random.order = FALSE,
          colors = brewer.pal(6, 'Dark2'))


#tidy로 변환
address.tf <- tidy(address.dtm)

address.tf <- address.tf %>%
  mutate(document = factor(document, levels = c("Clinton", "Bush", "Obama", "Trump", "Biden"))) %>%
  arrange(desc(count)) %>%
  group_by(document) %>%
  top_n(n=10, wt = count) %>% #상위 10개, count중심
  ungroup()
address.tf



ggplot(address.tf,
       aes(x=term, y=count, fill=document)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~document, ncol = 2, scales = "free") #대통령별로 +
labs(x=NULL, y = "Term Frequency count") +
  coord_flip()


ggplot(address.tf,
       aes(reorder_within(x=term, by=count, within = document), y=count, fill=document)) +
  geom_col(show.legend = FALSE)+
  facet_wrap(~document, ncol=2, scales = "free") +
  scale_x_reordered() +
  labs(x=NULL, y="Term Frequency count") +
  coord_flip()


address.dtm





# TF - IDF

address.dtm2 <- DocumentTermMatrix(address.corpus,
                                   control = list(weighting = weightTfIdf))
inspect(address.dtm2)

row.names(address.dtm2) <- c("Clinton", "Bush", "Obama", "Trump", "Biden")

address.tfidf <- tidy(address.dtm2) %>%
  mutate(tf_idf = count, count = NULL)


address.tfidf <- address.tfidf %>%
  mutate(document = factor(document, levels = c("Clinton", "Bush", "Obama", "Trump", "Biden"))) %>%
  arrange(desc(tf_idf)) %>%
  group_by(document) %>%
  top_n(n=10, wt = tf_idf) %>% #상위 10개, count중심
  ungroup()
address.tfidf





ggplot(address.tfidf,
       aes(reorder_within(x=term, by=tf_idf, within = document), y=tf_idf, fill=document)) +
  geom_col(show.legend = FALSE)+
  facet_wrap(~document, ncol=2, scales = "free") +
  scale_x_reordered() +
  labs(x=NULL, y="tf_idf") +
  coord_flip()


