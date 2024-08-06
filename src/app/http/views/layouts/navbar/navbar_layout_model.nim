import std/asyncdispatch
import std/options
import basolato/view
import ../../../../di_container
import ../../../../models/vo/user_id
import ../../../../models/dto/user/user_query_interface


type NavbarLayoutModel*  = object
  isLogin*: bool
  userId*:string
  userName*:string
  image*:string

proc new*(_:type NavbarLayoutModel):Future[NavbarLayoutModel] {.async.} =
  let context = context()
  let isLogin = context.isLogin().await
  let loginUserId = context.get("user_id").await

  if isLogin:
    let userId = UserId.new(loginUserId)
    let userQuery:IUserQuery = di.userQuery
    let userDto = userQuery.getUserById(userId).await
    let navbarViewModel = NavbarLayoutModel(
      isLogin:true,
      userId:userDto.id,
      userName:userDto.name,
      image:userDto.image,
    )
    return navbarViewModel
  else:
    let navbarViewModel = NavbarLayoutModel(isLogin:false, userId:"", userName:"", image:"")
    return navbarViewModel
