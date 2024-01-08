import std/asyncdispatch
import std/json

type IArticleQuery* = tuple
  getGlobalFeed:proc():Future[seq[JsonNode]]
