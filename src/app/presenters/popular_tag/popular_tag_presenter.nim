import std/asyncdispatch
import ../../models/dto/tag/polutar_tag_list_query_interface
import ../../models/dto/tag/tag_dto
import ../../http/views/templates/popular_tags/popular_tags_template_model
import ../../di_container

type PopularTagListPresenter* = object
  query:IPopularTagListQuery

proc new*(_:type PopularTagListPresenter):PopularTagListPresenter =
  return PopularTagListPresenter(
    query:di.popularTagListQuery
  )


proc invoke*(self:PopularTagListPresenter):Future[PopularTagsTemplateModel] {.async.} =
  let tagDtoList = self.query.invoke().await
  let model = PopularTagsTemplateModel.new(tagDtoList)
  return model
