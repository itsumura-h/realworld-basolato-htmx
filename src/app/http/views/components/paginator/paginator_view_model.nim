import ../../../../models/dto/paginator/paginator_dto


type PaginatorViewModel* = object
  current*:int
  lastPage*:int
  hasPages*:bool
  hxGetUrl*:string

proc new*(_:type PaginatorViewModel, dto:PaginatorDto, hxGetUrl:string):PaginatorViewModel =
  let lastPage = dto.total div dto.display
  let hasPages = lastPage > 1
  return PaginatorViewModel(
    current: dto.current,
    lastPage: lastPage,
    hasPages: hasPages,
    hxGetUrl: hxGetUrl,
  )
