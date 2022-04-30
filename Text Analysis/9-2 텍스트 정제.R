## 텍스트 분석 9-2 텍스트 정제

text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")
library(tm)

corpus.docs <- VCorpus(VectorSource(text))
source <- c("Dong-A", "Ryu", "Kim")
meta(corpus.docs, tag="author", type="local") <- source
lapply(corpus.docs, meta, tag="author")


lapply(corpus.docs, meta)


# 메타정보 추가
category <- c("health", "lifestyle", "business")
meta(corpus.docs, tag="category", type="local") <- category
lapply(corpus.docs, meta)


# 메타정보 삭제
meta(corpus.docs, tag="origin", type="local") <- NULL
lapply(corpus.docs, meta)


# 메타데이터 특정 조건 추출: tm_filter()
tm_filter(corpus.docs, FUN = function(x)
  any(grep("weight|diet", content(x))))

lapply(tm_filter(corpus.docs, FUN = function(x)
  any(grep("weight|diet", content(x)))),content
) 

corpus.docs_filter <- tm_filter(corpus.docs, FUN = function(x)
  any(grep("weight|diet", content(x))))

lapply(corpus.docs_filter,content)

meta(corpus.docs, "author") == "Dong-A" | meta(corpus.docs, "author") == "Ryu"
index <- meta(corpus.docs, "author") == "Dong-A" | meta(corpus.docs, "author") == "Ryu"
index

lapply(corpus.docs[index], content)


# corpus를 저장: writeCorpus()
writeCorpus(corpus.docs)
list.files(pattern="\\.txt")



# 텍스트 정제: 불필요한 요소 제거
getTransformations()

lapply(corpus.docs, content)

# 소문자로 변환
tm_map(corpus.docs, content_transformer(tolower))
corpus.docs <- tm_map(corpus.docs, content_transformer(tolower))
lapply(corpus.docs, content)

# 불용어 stopwords 제거
stopwords("english") #사전에 정의된 불용어

corpus.docs <- tm_map(corpus.docs, removeWords, stopwords("english"))
lapply(corpus.docs, content)

myRemoves <- content_transformer(function(x, pattern)
  {return(gsub(pattern, "", x))})
lapply(corpus.docs, content)

# url 제거
corpus.docs <- tm_map(corpus.docs, myRemoves, "(f|ht)tp\\S+\\s*")
lapply(corpus.docs, content)

# punctuation 제거
corpus.docs <- tm_map(corpus.docs,removePunctuation)
lapply(corpus.docs, content)

# 숫자 제거
corpus.docs <- tm_map(corpus.docs,removeNumbers)
lapply(corpus.docs, content)

# 공백 제거
corpus.docs <- tm_map(corpus.docs,stripWhitespace)
lapply(corpus.docs, content)

corpus.docs <- tm_map(corpus.docs, content_transformer(trimws))
lapply(corpus.docs, content)

# 어간, 어미 제거

corpus.docs <- tm_map(corpus.docs, stemDocument)
lapply(corpus.docs, content)


# 유의어 통합
corpus.docs <- tm_map(corpus.docs, content_transformer(gsub),
                      pattern="economist", replacement = "economi")
lapply(corpus.docs, content)


