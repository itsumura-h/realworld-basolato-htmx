import std/asyncdispatch
import interface_implements
import ../../models/vo/article_id
import ../../models/vo/user_id
import ./favorite_button_dto

interfaceDefs:
  type IGetFavoriteButtonQuery* = object of RootObj
    invoke: proc(self:IGetFavoriteButtonQuery, articleId:ArticleId, userId:UserId):Future[FavoriteButtonDto]
    invoke: proc(self:IGetFavoriteButtonQuery, articleId:ArticleId):Future[FavoriteButtonDto]
