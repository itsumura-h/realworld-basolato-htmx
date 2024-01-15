type Tag* = object
  id*:int
  name*:string
  popularTagsCount*:int

proc new*(_:type Tag, id:int, name:string, popularTagsCount:int):Tag =
  return Tag(
    id:id,
    name:name,
    popularTagsCount:popularTagsCount
  )


type HtmxTagItemListViewModel* = object
  tags*:seq[Tag]

proc new*(_:type HtmxTagItemListViewModel, tags:seq[Tag]):HtmxTagItemListViewModel =
  return HtmxTagItemListViewModel(
    tags:tags
  )
