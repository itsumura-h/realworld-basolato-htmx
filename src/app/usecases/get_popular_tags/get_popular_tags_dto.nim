type PopularTagDto* = object
  id*:int
  name*:string
  popularCount*:int

proc new*(_:type PopularTagDto, id:int, name:string, popularCount:int):PopularTagDto =
  return PopularTagDto(
    id:id,
    name:name,
    popularCount:popularCount
  )
