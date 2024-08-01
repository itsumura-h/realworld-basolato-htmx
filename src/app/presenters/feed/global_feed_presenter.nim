import std/asyncdispatch
import ../../http/views/pages/home/home_page_model
import ../../di_container


type GlobalFeedPresenter* = object

proc new*(_:type GlobalFeedPresenter):GlobalFeedPresenter =
  return GlobalFeedPresenter()


proc invoke*(self: GlobalFeedPresenter, isLogin:bool, loginUserId:string, offset:int, display:int):Future[HomePageModel] {.async.} =
  return HomePageModel.new(isLogin)
