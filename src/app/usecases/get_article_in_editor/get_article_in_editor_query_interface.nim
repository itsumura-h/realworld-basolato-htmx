import std/asyncdispatch
import interface_implements
import ../../models/aggregates/article/vo/article_id
import./get_article_in_editor_dto


interfaceDefs:
  type IGetArticleInEditorQuery* = object of RootObj
    invoke: proc(self:IGetArticleInEditorQuery, articleId:ArticleId):Future[ArticleInEditorDto]
