import std/asyncdispatch
import interface_implements
import ../../models/vo/article_id
import ../../models/vo/user_id
import ./favorite_button_in_user_dto

interfaceDefs:
  type IGetFavoriteButtonInUserQuery* = object of RootObj
    invoke: proc(self:IGetFavoriteButtonInUserQuery, articleId:ArticleId, userId:UserId):Future[FavoriteButtonInUserDto]
