import ../../../../../usecases/get_popular_tags/get_popular_tags_dto


type Tag*  = object
  id*:string
  name*:string
  popularCount*:int

proc init*(_:type Tag, id:string, name:string, popularCount:int):Tag =
  return Tag(
    id:id,
    name:name,
    popularCount:popularCount
  )


type HtmxTagItemListViewModel*  = object
  tags*:seq[Tag]

proc init*(_:type HtmxTagItemListViewModel, tagDtoList:seq[PopularTagDto]):HtmxTagItemListViewModel =
  var tags:seq[Tag]
  for row in tagDtoList:
    let tag = Tag.init(
      id = row.id,
      name = row.name,
      popularCount = row.popularCount
    )
    tags.add(tag)

  return HtmxTagItemListViewModel(
    tags:tags
  )
