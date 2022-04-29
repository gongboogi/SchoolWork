## 텍스트 분석 9-1 텍스트구조화(Corpus)
#Corpus: 비정형의 텍스트를 구조화된 데이터로 변환

text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

install.packages("tm")
library(tm)
crude
data(crude)
crude #corpus유형 데이터셋

crude[[1]]
crude[[1]]$content
crude[[1]]$meta
text

VCorpus()
getSources() #읽어들일 수 있는 소스 확인

VectorSource(text) #벡터로 읽음
VCorpus(VectorSource(text))

corpus.docs <- VCorpus(VectorSource(text))
class(corpus.docs)

corpus.docs

inspect(corpus.docs[1])
inspect(corpus.docs[[1]])

as.character(corpus.docs[[1]])

lapply(corpus.docs, as.character)


str(corpus.docs)

corpus.docs[[1]]$content
lapply(corpus.docs,content)

unlist(corpus.docs,content)
as.vector(unlist(corpus.docs,content))

paste(as.vector(unlist(lapply(corpus.docs,content))),collapse=" ")


corpus.docs[[1]]$meta
meta(corpus.docs[[1]])
meta(corpus.docs[[1]], tag = "author")
meta(corpus.docs[[1]], tag = "id")

meta(corpus.docs[[1]], tag = "author", type = "local") <- "Dong-A"

cor.author <- c("Dong-A", "Ryu", "Kim")
meta(corpus.docs[[1]], tag="author", type="local") <- cor.author
lapply(corpus.docs, meta)
lapply(corpus.docs, meta, tag="author")
