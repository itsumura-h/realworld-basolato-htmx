import std/asyncdispatch
import std/options
import interface_implements
import ../../models/aggregates/article/vo/article_id
import ../../models/aggregates/user/vo/user_id
import ./get_article_dto

interfaceDefs:
  type IGetArticleQuery*  = object of RootObj
    invoke:proc(self:IGetArticleQuery, articleId:ArticleId, loginUserId:Option[UserId]):Future[GetArticleDto]
