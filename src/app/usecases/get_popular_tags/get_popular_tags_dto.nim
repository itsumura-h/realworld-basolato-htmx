type PopularTagDto*  = object
  id*:string
  name*:string
  popularCount*:int

proc init*(_:type PopularTagDto, id:string, name:string, popularCount:int):PopularTagDto =
  return PopularTagDto(
    id:id,
    name:name,
    popularCount:popularCount
  )
