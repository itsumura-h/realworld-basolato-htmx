import std/asyncdispatch
import std/options
import interface_implements
import ../../models/aggregates/article/vo/article_id
import ../../models/aggregates/user/vo/user_id
import ./get_article_in_feed_dto

interfaceDefs:
  type IGetArticleInFeedQuery*  = object of RootObj
    invoke:proc(self:IGetArticleInFeedQuery, articleId:ArticleId, loginUserId:Option[UserId]):Future[GetArticleInFeedDto]
