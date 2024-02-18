import ../../../../errors

type ArticleId*  = object
  value*:string

proc init*(_:type ArticleId, value:string):ArticleId =
  if value.len == 0:
    raise newException(DomainError, "article id is empty")
  
  return ArticleId(
    value:value
  )
