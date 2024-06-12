import ../../../../models/dto/paginator/paginator_dto


type PaginatorViewModel* = object
  current*:int
  lastPage*:int
  hasPages*:bool
  hxGetUrl*:string
  hxPushUrl*:string

proc new*(_:type PaginatorViewModel, dto:PaginatorDto, hxGetUrl:string, hxPushUrl:string):PaginatorViewModel =
  let lastPage =
    if (dto.total mod dto.display) > 0:
      (dto.total div dto.display) + 1
    else:
      dto.total div dto.display

  let hasPages = lastPage > 1

  return PaginatorViewModel(
    current: dto.current,
    lastPage: lastPage,
    hasPages: hasPages,
    hxGetUrl: hxGetUrl,
    hxPushUrl: hxPushUrl,
  )
