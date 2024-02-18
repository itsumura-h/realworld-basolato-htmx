type User*  = object
  name*:string
  email*:string
  bio*:string
  image*:string

proc init*(_:type User, name:string, email:string, bio:string, image:string): User =
  return User(
    name: name,
    email: email,
    bio: bio,
    image: image
  )


type FormViewModel*  = object
  oobSwap*:bool
  user*:User

proc init*(_:type FormViewModel, oobSwap:bool, name:string, email:string, bio:string, image:string): FormViewModel =
  let user = User.init(name, email, bio, image)
  return FormViewModel(
    user: user,
    oobSwap: oobSwap
  )
