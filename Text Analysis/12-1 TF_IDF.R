## 텍스트 분석 12-1 빈도분석(TF_IDF)
# 오즈비의 한계: 두 조건의 확률을 이용해 계산해서 여러 텍스트 비교하기 불편하다.
# 두 개 이상의 텍스트를 비교 -> TF_IDF
# TF(단어빈도, term frequency)
# 점수가 높을 수록 다른 문서에 많지 않고 해당 문서에서 자주 등장하는 단어

install.packages("quanteda")

library(quanteda)
data_corpus_inaugural # 미국 대통령 연설문
summary(data_corpus_inaugural)
class(data_corpus_inaugural)

library(tidytext)
library(tibble)
library(dplyr)

#tibble형태로 변환

us.president.address <- tidy(data_corpus_inaugural) %>%
  filter(Year > 1990) %>%
  group_by(President, FirstName) %>%
  summarise_all(list(~trimws(paste(., collapse = " ")))) %>% #연임대통령 연설문 합치기
  arrange(Year) %>%
  ungroup() #group 해제

us.president.address

library(tm)
?DataframeSource #이용하려면 doc_id, text가 필요


us.president.address <- us.president.address %>%
  select(text, everything()) %>%
  add_column(doc_id = 1:nrow(.), .before = 1)

us.president.address

address.corpus <- VCorpus(DataframeSource(us.president.address))

lapply(address.corpus[1], content)

