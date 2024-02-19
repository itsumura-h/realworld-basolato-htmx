type PopularTagDto*  = object
  id*:string
  name*:string
  popularCount*:int

proc new*(_:type PopularTagDto, id:string, name:string, popularCount:int):PopularTagDto =
  return PopularTagDto(
    id:id,
    name:name,
    popularCount:popularCount
  )
