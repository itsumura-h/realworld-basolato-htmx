import std/strutils
import ./title

type ArticleId* = object
  value*:string

proc new*(_:type ArticleId, value:string):ArticleId =
  return ArticleId(value: value)

proc new*(_:type ArticleId, title:Title):ArticleId =
  let value = title.value.replace(" ", "-").toLower()
  return ArticleId(value: value)
