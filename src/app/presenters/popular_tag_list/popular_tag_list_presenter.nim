import std/asyncdispatch
import ../../models/dto/tag/tag_list_query_interface
import ../../http/views/pages/home/htmx_tag_list/htmx_tag_list_view_model
import ../../di_container


type PopularTagListPresenter* = object
  tagListQuery: ITagListQuery

proc new*(_:type PopularTagListPresenter):PopularTagListPresenter =
  return PopularTagListPresenter(
    tagListQuery: di.tagListQuery
  )


proc invoke*(self:PopularTagListPresenter):Future[HtmxTagListViewModel] {.async.} =
  const tagCount = 10
  let tagDtoList = self.tagListQuery.invoke(tagCount).await
  let viewModel = HtmxTagListViewModel.new(tagDtoList)
  return viewModel
