type Tag* = ref object
  id*:int
  name*:string
  favoriteCount*:int

proc new*(_:type Tag, id:int, name:string, favoriteCount:int):Tag =
  return Tag(
    id:id,
    name:name,
    favoriteCount:favoriteCount
  )


type HtmxTagItemListViewModel* = ref object
  tags*:seq[Tag]

proc new*(_:type HtmxTagItemListViewModel, tags:seq[Tag]):HtmxTagItemListViewModel =
  return HtmxTagItemListViewModel(
    tags:tags
  )
